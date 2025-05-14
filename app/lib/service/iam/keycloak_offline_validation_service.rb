module Service
  module Iam
    class KeycloakOfflineValidationService < AbstractValidationService
        JWKS_URI = ENV["IAM_JWKS_URI"]

        def initialize
            @http_client = HttpClient.new
            @jwks = fetch_jwks
        end

        def validate(request)
            token = get_bearer_token(request)
            verify_token(token)
        end

        def fetch_jwks
            response = @http_client.get(JWKS_URI)
            response.body
        rescue StandardError => e
            Rails.logger.error("Failed to fetch JWKS: #{e.message}")
            nil
        end

        def find_public_key(kid)
            return nil unless @jwks

            @jwks["keys"].find { |key| key["kid"] == kid }
        end

        def verify_token(token)
            header = JWT.decode(token, nil, false, verify: false, decode: true).last
            kid = header["kid"]

            public_key_data = find_public_key(kid)
            return nil unless public_key_data

            public_key = OpenSSL::X509::Certificate.new(
            "-----BEGIN CERTIFICATE-----\n#{public_key_data['x5c'][0]}\n-----END CERTIFICATE-----"
            ).public_key

            decoded_token = JWT.decode(token, public_key, true, { algorithm: "RS256" })
            decoded_token[0]
        rescue JWT::DecodeError => e
            Rails.logger.error("JWT verification failed: #{e.message}")
            nil
        end

        def save_user(user_info)
            User.create(
                iam_id: user_info["sub"],
                name: user_info["name"],
                email: user_info["email"]
            )
        end

        def is_role_exist?(user_info, role)
          user_roles = user_info["realm_access"]["roles"]
          user_roles.any? { |user_role | user_role == role }
        end
    end
  end
end

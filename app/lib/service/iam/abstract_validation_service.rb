module Service
    module Iam
      class AbstractValidationService
        # Should return user infor after validation
        def validate(request)
          raise "Not implemented"
        end

        def is_role_exist?(user_info, role)
          raise "Not implemented"
        end

        def save_user(user_info)
          raise "Not implemented"
        end

        def get_bearer_token(request)
            pattern = /^Bearer /
            header  = request.headers["Authorization"]

            if header&.match(pattern)
              header.gsub(pattern, "")
            else
              nil
            end
        end
      end
    end
end

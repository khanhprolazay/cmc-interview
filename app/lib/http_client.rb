=begin
  request: :json or :url_encoded. Default is :json
  url: url of the service
  response will be in json format

  Example:
  client = HttpClient.new(
    request: :url_encoded,
    url: url
  )
=end

class HttpClient
    def initialize(opts = {})
        @conn = Faraday.new(url: opts[:url]) do |faraday|
        faraday.request opts[:request] || :json
        faraday.response :json
        end
    end

    def get(uri, params = nil, headers = nil)
        res = @conn.get(uri, params, headers)
        handle_response(res)
    end

    def post(uri, body = nil, headers = nil)
        res = @conn.post(uri, body, headers)
        handle_response(res)
    end

    def put(uri, body = nil, headers = nil)
        res = @conn.put(uri, body, headers)
        handle_response(res)
    end

    def patch(uri, body = nil, headers = nil)
        res = @conn.patch(uri, body, headers)
        handle_response(res)
    end

    def delete(uri, params = nil, headers = nil)
        res = @conn.delete(uri, params, headers)
        handle_response(res)
    end

    def set_headers(headers)
        @conn.headers.update(headers)
    end

    private
    def handle_response(response)
        if response.status >= 400
            puts "Error: #{response.status}"
            puts "Error: #{response.body}"
        end
        response
    end
end

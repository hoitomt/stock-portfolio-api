module Api
  class Github
    class << self
      def auth_code_url
        "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=#{ENV['GITHUB_REDIRECT_URL']}&scope=user&state=abc123"
      end

      def get_user(access_token)
        response = Faraday.get('https://api.github.com/user', {}, {'Authorization' => "token #{access_token}", 'Accept' => 'application/json'})
        parse_response(response)
      rescue Exception => e
        puts e
      end

      def get_access_token(auth_code)
        req_params = {
          client_id: ENV['GITHUB_CLIENT_ID'],
          client_secret: ENV['GITHUB_CLIENT_SECRET'],
          code: auth_code,
          redirect_uri: ENV['GITHUB_REDIRECT_URL']
        }
        response = Faraday.post('https://github.com/login/oauth/access_token', req_params, { 'Accept' => 'application/json' })
        parse_response(response)["access_token"]
      rescue Exception => e
        puts e
      end

      def parse_response(response)
        j_response = JSON.parse(response.body)
        if j_response["error"]
          raise j_response["error_description"]
        end
        j_response
      # rescue JSON::ParserError => e
      end

    end

  end
end

module Api
  class Securities
    class << self
      def lookup(query)
        url = "#{ENV['SECURITIES_HOST']}/Lookup/json?input=#{query}"
        response = Faraday.get(url, {}, {'Accept' => 'application/json'})
        parse_response(response)
      end

      def quote(ticker)
        url = "#{ENV['SECURITIES_HOST']}/Quote/json?symbol=#{ticker}"
        response = Faraday.get(url, {}, {'Accept' => 'application/json'})
        parse_response(response)
      end

      def parse_response(response)
        JSON.parse(response.body)
      end
    end

  end
end
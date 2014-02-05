module Diffbot
  class APIClient

    # Diffbot Batch class
    class Batch
      # Initializes a new Batch object
      #
      # @param client [Diffbot::APIClient]
      # @param options [Hash]
      def initialize client, options = {}
        raise ArgumentError.new("client should be an instance of Diffbot::APIClient") unless client.is_a?(Diffbot::APIClient)
        @client = client

        @params = {
          :token => @client.token,
        }

        @list = []
      end

      # Return request URL
      #
      # @return [URI::HTTP]
      def url
        "http://www.diffbot.com/" + path
      end

      # Return request path
      #
      # @return [String]
      def path
        "api/batch"
      end

      # Add a request (API object) to batch
      def << req
        raise ArgumentError.new("argument should be an instance of Diffbot::APIClient::GenericAPI") unless req.is_a?(Diffbot::APIClient::GenericAPI)

        @list << req
      end

      # Execute batch
      def execute
        req_array = []
        @list.each do |item|
          req_array.push(
            :method => "GET",
            :relative_url => item.relative_full_url,
          )
        end

        post(:batch => req_array)
      end

      private

      def post prms = {}
        headers = {} 
        headers[:accept] = "application/json"

        @client.post(self.url, @params.merge(prms), headers)
      end
    end
  end
end

module Diffbot
  class APIClient

    # Diffbot Custom API class
    class Custom < GenericAPI
      ALLOWED_PARAMS = [:timeout]

      # Custom API name
      #
      # @return [String]
      attr_reader :name

      # Initializes a new Custom API object
      #
      # @param client [Diffbot::APIClient]
      # @param name [String]
      # @param options [Hash]
      # @return [Diffbot::APIClient::Custom]
      def initialize client, name, options = {}
        @name = name
        super(client, options)
      end

      # Return request path
      #
      # @return [String]
      def path
        "v3/#{name}"
      end

      # Return request URL
      #
      # @return [URI::HTTP]
      def url
        "http://api.diffbot.com/" + path
      end

      private

      def parse_params source
        generic_parse_params source, params
      end
    end

  end
end

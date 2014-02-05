module Diffbot
  class APIClient

    # Diffbot Crawlbot API class
    class Crawlbot < Bot
      # Initializes a new Crawlbot API object
      #
      # @param client [Diffbot::APIClient]
      # @param options [Hash]
      # @return [Diffbot::APIClient::Crawlbot]
      def initialize client, options = {}
        super(client, options)

        get(parse_params(options))
      end

      # Return request path
      #
      # @return [String]
      def path
        "v2/crawl"
      end

      private

      def parse_params source
        target = source.dup

        if target[:seeds].is_a?(Array)
          target[:seeds] = target[:seeds].join(" ")
        end

        target
      end
    end

  end
end

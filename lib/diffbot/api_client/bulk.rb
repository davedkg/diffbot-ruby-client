module Diffbot
  class APIClient

    # Diffbot Bulk API class
    class Bulk < Bot
      # Initializes a new Bulk API object
      #
      # @param client [Diffbot::APIClient]
      # @param options [Hash]
      # @return [Diffbot::APIClient::Bulk]
      def initialize client, options = {}
        super(client, options)
      end

      # Return request path
      #
      # @return [String]
      def path
        "v2/bulk"
      end

      private

      def parse_params source
        target = source.dup

        if target[:urls].is_a?(Array)
          target[:urls] = target[:urls].join(" ")
        end

        target
      end
    end

  end
end

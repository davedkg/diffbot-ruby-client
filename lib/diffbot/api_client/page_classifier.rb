module Diffbot
  class APIClient

    # Diffbot PageClassifier API class
    class PageClassifier < GenericAPI
      ALLOWED_PARAMS = [:mode, :fields, :stats]
      DEFAULT_VERSION = 2

      # Initializes a new PageClassifier API object
      #
      # @param client [Diffbot::APIClient]
      # @param options [Hash]
      # @return [Diffbot::APIClient::PageClassifier]
      def initialize client, options = {}
        @version = options.delete(:version) || DEFAULT_VERSION
        super(client, options)
      end

      # Return request path
      #
      # @return [String]
      def path
        "v#{@version}/analyze"
      end

      private

      def parse_params source
        target = {}

        ALLOWED_PARAMS.each do |param|
          next unless source.keys.include?(param)

          case param
          when :fields
            target[param] = source[param].is_a?(Array) ? source[param].join(",") : source[param]
          when :stats
            target[param] = !!source[param]
          else
            target[param] = source[param]
          end
        end

        target
      end
    end

  end
end

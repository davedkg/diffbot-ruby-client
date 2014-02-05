module Diffbot
  class APIClient

    # Diffbot PageClassifier API class
    class Analyze < GenericAPI
      ALLOWED_PARAMS = [:mode, :fields, :stats]

      # Initializes a new Analyze API object
      #
      # @param client [Diffbot::APIClient]
      # @param options [Hash]
      # @return [Diffbot::APIClient::Analyze]
      def initialize client, options = {}
        super(client, options)
      end

      # Return request path
      #
      # @return [String]
      def path
        "v22/analyze"
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

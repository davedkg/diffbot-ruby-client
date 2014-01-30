module Diffbot
  class APIClient

    # Diffbot Frontpage API class
    class Frontpage < GenericAPI
      ALLOWED_PARAMS = [:format, :timeout, :all]
      ALLOWED_FORMATS = [:xml, :json]

      # Initializes a new Frontpage API object
      #
      # @param client [Diffbot::APIClient]
      # @param options [Hash]
      # @return [Diffbot::APIClient::Frontpage]
      def initialize client, options = {}
        @accept = :xml
        super(client, options)
      end

      # Return request path
      #
      # @return [String]
      def path
        "api/frontpage"
      end

      # Return request URL
      #
      # @return [URI::HTTP]
      def url
        "http://www.diffbot.com/" + path
      end

      private

      def parse_params source
        target = {}

        ALLOWED_PARAMS.each do |param|
          next unless source.keys.include?(param)

          case param
          when :format
            format = source[param] || @accept
            raise ArgumentError.new("format needs to be either :xml or :json") unless ALLOWED_FORMATS.include?(format)
            @accept = target[param] = source[param]
          when :all
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

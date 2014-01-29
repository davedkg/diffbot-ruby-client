module Diffbot
  class APIClient

    # Custom error class for rescuing from all Diffbot errors
    class Error < StandardError
      attr_reader :cause
      alias_method :wrapped_exception, :cause

      private

      # Initializes a new Error object
      #
      # @param exception [Exception, String]
      # @param response_headers [Hash]
      # @param code [Integer]
      # @return [Diffbot::Error]
      def initialize(exception = $ERROR_INFO)
        @cause = exception
        exception.respond_to?(:message) ? super(exception.message) : super(exception.to_s)
      end
    end

    # Raised when the Faraday connection times out
    class RequestTimeout < Error
    end

  end
end

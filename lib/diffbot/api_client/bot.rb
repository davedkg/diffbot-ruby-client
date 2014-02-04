module Diffbot
  class APIClient

    # Diffbot Bot class
    class Bot
      # Initializes a new Bot object
      #
      # @param client [Diffbot::APIClient]
      # @param options [Hash]
      def initialize client, options = {}
        @api = options.delete(:api)
        raise ArgumentError.new("client should be an instance of Diffbot::APIClient::GenericAPI") unless @api.is_a?(Diffbot::APIClient::GenericAPI)

        options[:apiUrl] = @api.full_url

        raise ArgumentError.new("client should be an instance of Diffbot::APIClient") unless client.is_a?(Diffbot::APIClient)
        @client = client

        @params = {
          :token => @client.token,
          :name => options.delete(:name)
        }

        post(parse_params(options))
      end

      # Return request URL
      #
      # @return [URI::HTTP]
      def url
        @client.endpoint + path
      end

      # Get job details
      #
      # @return [Hash]
      def details
        post
      end

      # Pause job
      #
      # @return [Hash]
      def pause
        post(:pause => 1)
      end

      # Resume job
      #
      # @return [Hash]
      def resume
        post(:pause => 0)
      end

      # Delete job
      #
      # @return [Hash]
      def delete
        post(:delete => 0)
      end

      # Download job data
      #
      # @return [Hash]
      def download what = :data
        if details[:jobs]
          job = nil
          details[:jobs].each do |j|
            if j[:name] == @params[:name]
              job = j
              break
            end
          end

          headers = {} 
          case what
          when :urls
            download_key = :downloadUrls
            headers[:accept] = "text/csv"
          else
            download_key = :downloadJson
            headers[:accept] = "application/json"
          end

          @client.get(job[download_key], {}, headers).body
        end
      end

      private

      def post prms = {}
        headers = {} 
        headers[:accept] = "application/json"

        @client.post(self.url, @params.merge(prms), headers).body
      end
    end

  end
end

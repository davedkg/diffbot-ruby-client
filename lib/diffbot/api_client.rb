require 'json'
require 'faraday'

require 'diffbot/api_client/version'
require 'diffbot/api_client/error'
require 'diffbot/api_client/faraday'
require 'diffbot/api_client/generic_api'
require 'diffbot/api_client/article'
require 'diffbot/api_client/frontpage'
require 'diffbot/api_client/image'
require 'diffbot/api_client/product'
require 'diffbot/api_client/page_classifier'
require 'diffbot/api_client/custom'
require 'diffbot/api_client/bot'
require 'diffbot/api_client/bulk'

module Diffbot

  # Main Diffbot API client class
  class APIClient
    attr_writer :connection_options, :middleware

    # Developer token
    #
    # @return [String]
    attr_accessor :token

    ENDPOINT = 'http://api.diffbot.com/'

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Diffbot::APIClient]
    def initialize(options = {})
      options.each do |key, value|
        send(:"#{key}=", value)
      end
      yield self if block_given?
    end

    def connection_options
      @connection_options ||= {
        :builder => middleware,
        :headers => {
          :accept => 'application/json',
          :user_agent => user_agent,
        },
        :request => {
          :open_timeout => 10,
          :timeout => 30,
        },
      }
    end

    # @note Faraday's middleware stack implementation is comparable to that of Rack middleware. The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
    # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
    # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
    # @return [Faraday::RackBuilder]
    def middleware
      #Faraday::Response.register_middleware :parse_json => Twitter::REST::Response::ParseJson

      @middleware ||= Faraday::RackBuilder.new do |faraday|
        # Checks for files in the payload, otherwise leaves everything untouched
        faraday.request :multipart
        # Encodes as "application/x-www-form-urlencoded" if not already encoded
        faraday.request :url_encoded
        # Handle error responses
        faraday.response :raise_error
        # Parse JSON response bodies
        faraday.response :parse_json
        # Set default HTTP adapter
        faraday.adapter :net_http
      end
    end

    # Returns client endpoint url
    #
    # @return [String]
    def endpoint
      connection.url_prefix
    end

    # @return [String]
    def user_agent
      @user_agent ||= "Diffbot Ruby API Client #{APIClient::VERSION::STRING}"
    end

    # Perform an HTTP GET request
    def get(path, params = {}, headers = {})
      request(:get, path, params, headers)
    end

    # Perform an HTTP POST request
    def post(path, data, headers = {})
      request(:post, path, data, headers)
    end

    # Creates new Article API object
    #
    # @param options [Hash]
    # @return [Diffbot::APIClient::Article]
    def article options = {}
      Diffbot::APIClient::Article.new self, options
    end

    # Creates new Frontpage API object
    #
    # @param options [Hash]
    # @return [Diffbot::APIClient::Frontpage]
    def frontpage options = {}
      Diffbot::APIClient::Frontpage.new self, options
    end

    # Creates new Image API object
    #
    # @param options [Hash]
    # @return [Diffbot::APIClient::Image]
    def image options = {}
      Diffbot::APIClient::Image.new self, options
    end

    # Creates new Product API object
    #
    # @param options [Hash]
    # @return [Diffbot::APIClient::Product]
    def product options = {}
      Diffbot::APIClient::Product.new self, options
    end

    # Creates new Page Classifier API object
    #
    # @param options [Hash]
    # @return [Diffbot::APIClient::PageClassifier]
    def page_classifier options = {}
      Diffbot::APIClient::PageClassifier.new self, options
    end

    # Creates new Custom API object
    #
    # @param name [String]
    # @param options [Hash]
    # @return [Diffbot::APIClient::Custom]
    def custom name, options = {}
      Diffbot::APIClient::Custom.new self, name, options
    end

    # Creates new Bulk API object
    #
    # @param args [Hash]
    # @param options [Hash]
    # @return [Diffbot::APIClient::Bulk]
    def bulk options = {}
      Diffbot::APIClient::Bulk.new self, options
    end

    private

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(ENDPOINT, connection_options)
    end

    def request(method, path, data = {}, headers = {})
      response = connection.send(method.to_sym, path, data) do |request|
        request.headers.update(headers)
      end
      response.env
    rescue Faraday::Error::TimeoutError, Timeout::Error => error
      raise(Diffbot::APIClient::Error::RequestTimeout.new(error))
    rescue Faraday::Error::ClientError, JSON::ParserError => error
      fail(Diffbot::APIClient::Error.new(error))
    end
  end

end

require 'spec_helper'

describe Diffbot::APIClient do
  describe "initalization" do
    it "should instantiate" do
      client = Diffbot::APIClient.new
      client.should be_an_instance_of(Diffbot::APIClient)
    end

    it "should accept options" do
      client = Diffbot::APIClient.new(:token => DEVELOPER_TOKEN)
      client.token.should eq(DEVELOPER_TOKEN)
    end

    it "should accept block" do
      client = Diffbot::APIClient.new do |config|
        config.token = DEVELOPER_TOKEN
      end
      client.token.should eq(DEVELOPER_TOKEN)
    end

    it "should return endpoint" do
      client = Diffbot::APIClient.new
      client.endpoint.to_s.should eq(Diffbot::APIClient::ENDPOINT)
    end
  end

  describe "generic calls" do
    it "get" do
      client = Diffbot::APIClient.new(:token => DEVELOPER_TOKEN)
      response = client.get "v2/analyze", {:token => client.token, :url => "http://diffbot.com"}
      response.should be_a(Hash)
      response[:url].should eq("http://diffbot.com")
    end
  end
end

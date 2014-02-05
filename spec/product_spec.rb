require 'spec_helper'

describe Diffbot::APIClient::Product do
  describe "initalization" do
    it "get" do
      client = Diffbot::APIClient.new(:token => DEVELOPER_TOKEN)

      product = client.product.query(:fields => [:title], :timeout => 2000)

      response = product.get("http://www.diffbot.com")
      response.should be_a(Hash)
      response[:url].should eq("http://www.diffbot.com")
    end
  end
end

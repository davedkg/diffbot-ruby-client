require 'spec_helper'

describe Diffbot::APIClient::Image do
  describe "initalization" do
    it "get" do
      client = Diffbot::APIClient.new(:token => DEVELOPER_TOKEN)

      image = client.image.query(:fields => [:title], :timeout => 2000)

      response = image.get("http://www.diffbot.com")
      response.should be_a(Hash)
      response[:url].should eq("http://www.diffbot.com")
      response[:images].should be_an(Array)
    end
  end
end

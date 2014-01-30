require 'spec_helper'

describe Diffbot::APIClient::Frontpage do
  describe "initalization" do
    it "get" do
      client = Diffbot::APIClient.new(:token => DEVELOPER_TOKEN)

      response = client.custom("custom_test").get("http://www.diffbot.com")

      response.should be_a(Hash)
      response[:name].should eq("a visual\n learning robot")
    end
  end
end

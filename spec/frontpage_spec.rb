require 'spec_helper'

describe Diffbot::APIClient::Frontpage do
  describe "initalization" do
    it "get" do
      client = Diffbot::APIClient.new(:token => DEVELOPER_TOKEN)

      response = client.frontpage.get("http://www.diffbot.com")

      response.should be_a(String)
      response.should include("<dml>")

      response = client.frontpage.query(:format => :json).get("http://www.diffbot.com")
      response.should be_a(Hash)
    end
  end
end

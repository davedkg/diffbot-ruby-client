require 'spec_helper'

describe Diffbot::APIClient::Analyze do
  describe "initalization" do
    it "get" do
      client = Diffbot::APIClient.new(:token => DEVELOPER_TOKEN)

      response = client.analyze.query(:mode => "article", :stats => true).get("http://www.diffbot.com")
      response.should be_a(Hash)
      response.should have_key(:stats)
    end
  end
end

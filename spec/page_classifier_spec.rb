require 'spec_helper'

describe Diffbot::APIClient::PageClassifier do
  describe "initalization" do
    it "get" do
      client = Diffbot::APIClient.new(:token => DEVELOPER_TOKEN)

      response = client.page_classifier.query(:mode => "article", :stats => true).get("http://www.diffbot.com")
      response.should be_a(Hash)
      response.should have_key(:stats)
    end
  end
end

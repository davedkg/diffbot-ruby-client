require 'spec_helper'

describe Diffbot::APIClient::Crawlbot do
  describe "initalization" do
    it "should handle API versions" do
      client = Diffbot::APIClient.new
      bot = client.crawlbot(
        :name => "test",
        :seeds => ["http://www.diffbot.com"],
        :api => client.analyze
      )

      bot.details[:jobs].should_not be_empty
      bot.download
      bot.delete.should be_a(Hash)
    end
  end
end

require 'spec_helper'

describe Diffbot::APIClient::Bulk do
  describe "initalization" do
    it "should handle API versions" do
      client = Diffbot::APIClient.new
      bulk = client.bulk(
        :name => "test",
        :urls => ["http://www.diffbot.com"],
        :api => client.article
      )

      bulk.details[:jobs].should_not be_empty
      bulk.download
      bulk.delete.should be_a(Hash)
    end
  end
end

require 'spec_helper'

describe Diffbot::APIClient::Batch do
  it "should work" do
    client = Diffbot::APIClient.new(:token => DEVELOPER_TOKEN)

    batch = client.batch
    batch << client.article.query(:fields => [:title, :link, :text], :method => :get, :url => "http://diffbot.com/")

    response = batch.execute
    response.should be_a(Hash)
  end
end

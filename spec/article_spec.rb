require 'spec_helper'

describe Diffbot::APIClient::Article do
  describe "initalization" do
    it "should instantiate" do
      expect { Diffbot::APIClient::Article.new("foo") }.to raise_error(ArgumentError)
      Diffbot::APIClient::Article.new(Diffbot::APIClient.new).should be_a(Diffbot::APIClient::Article)
      Diffbot::APIClient.new.article.should be_a(Diffbot::APIClient::Article)
    end

    it "should handle API versions" do
      client = Diffbot::APIClient.new
      client.article.version.should eq(2)
      client.article(:version => 1).version.should eq(1)
      client.article.url.to_s.should eq(Diffbot::APIClient::ENDPOINT + "v2/article")
    end

    it "get" do
      client = Diffbot::APIClient.new(:token => DEVELOPER_TOKEN)
      article = client.article
      article.url.to_s.should eq(Diffbot::APIClient::ENDPOINT + "v2/article")

      article = client.article.query(:fields => [:title], :timeout => 2000)
      response = article.get("http://www.diffbot.com")
      response.should be_a(Hash)
      response[:url].should eq("http://www.diffbot.com")
      response.keys.include?(:html).should be_false
    end

    it "post" do
      client = Diffbot::APIClient.new(:token => DEVELOPER_TOKEN)
      article = client.article.query(:fields => [:title], :timeout => 2000)
      response = article.post("http://www.diffbot.com/products/automatic/article", "Now is the time for all good robots to come to the aid of their-- oh never mind, run!")
      response.should be_a(Hash)
      response[:url].should eq("http://www.diffbot.com/products/automatic/article")
    end

    it "execute" do
      client = Diffbot::APIClient.new(:token => DEVELOPER_TOKEN)
      article = client.article.query(:method => :get, :query_url => "http://www.diffbot.com", :fields => [:title], :timeout => 2000)
      response = article.execute
      response.should be_a(Hash)
      response[:url].should eq("http://www.diffbot.com")
      response.keys.include?(:html).should be_false
    end
  end
end

# Diffbot API Ruby client

## Preface

This is a Ruby client library for [Diffbot][] API.

[Diffbot]: http://www.diffbot.com

## Installation

Require diffbot in your app

    require "diffbot"

## Configuration

Obtaining Ruby Diffbot client is simple as that:

```ruby
client = Diffbot::APIClient.new
```

This allows to build thread-safe applications and to keep at a time multiple client instances with different setup.

Initializer can accept also a block which allows us to do some fancy setup stuff:

```ruby
client = Diffbot::APIClient.new do |config|
  config.token = ENV["DIFFBOT_TOKEN"]
end
```

Once we've got token configured, we can move on to making actual requests.

### Middleware

API uses [Faraday][] as a HTTP middleware library. It can be configured as usual, even within initialization block:

```ruby
client = Diffbot::APIClient.new do |config|
  config.middleware = Faraday::Builder.new(
    &Proc.new do |builder|
      # Specify a middleware stack here
      builder.adapter :some_other_adapter
    end
  )
end
```

[Faraday]: https://github.com/lostisland/faraday

## Usage

### Article API

Assume that we have our `client` configured. In order to use Automatic Article API we need to instantiate Article API instance first:

```ruby
client.article # => Diffbot::APIClient::Article
client.article(:version => 1) # Instantiate API version 1 (2 is default)
```

Then we need to specify the query:

```ruby
article = client.article.query(:fields => [:title, :link, :text], :timeout => 2000)
article # => Diffbot::APIClient::Article
```

And then do GET or POST request:

```ruby
response = article.get("http://someurl.com/")
response[:title] # => "Some page title"

response = article.post("http://someurl.com/", content)
```

We can also make a sweet one-liner out of it:

```ruby
response = client.article.get("http://someurl.com/")
```

There is also an alternative syntax for making requests:

```ruby
article = client.article.query(
  :fields => [:title, :link, :text], 
  :timeout => 2000, 
  :method => :get, 
  :url => "http://someurl.com/"
)
response = article.execute
```

### Frontpage API

Calling Fronpage API is also pretty simple:

```ruby
response = client.frontpage.get("http://someurl.com/")
```

By default DML is returned in response. You can change this by adding `:format` to `query`:

```ruby
response = client.frontpage.query(:format => :json).get("http://someurl.com/")
```

### Image API

```ruby
response = client.image.get("http://someurl.com/")
```

### Product API

```ruby
response = client.product.get("http://someurl.com/")
```

### Page Classifier API

Similarly, here's how you would call Page Classifier API:

```ruby
response = client.page_classifier.query(:mode => "article", :stats => true).get("http://someurl.com/")
```

### Custom API

With Custom API you need to supply its name:

```ruby
response = client.custom("my-custom-api").get("http://someurl.com/")
```

### Bulk API

Bulk API allows to submit jobs to Diffbot. Jobs can use different apis to analyse websites. This requires to supply apiUrl which will be used to perform crawling. Ruby client makes possible to avoid using urls here. Instead, it is possible to use Ruby API objects described above:

```ruby
bulk = client.bulk(
  :name => "bulk-job",
  :urls => ["http://someurl.com/", "http://foo.com/"],
  :api => client.article.query(:fields => [:title, :text]),
  :options => bulk_arguments_hash
)
```

`api` argument here can accept any valid API object with or without extra query parameters.

Once we got bulk object constructed, we can get job details, pause it, resume or delete:

```ruby
bulk.details
bulk.pause
bulk.resume
bulk.delete
```

Finally, we can obtain result of bulk job:

```ruby
bulk.download
bulk.download(:urls)
```

## License

Please see LICENSE for licensing details.

## Author

Łukasz Jachymczyk, [http://www.sology.eu](http://www.sology.eu)

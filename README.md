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

## License

Please see LICENSE for licensing details.

## Author

Łukasz Jachymczyk, [http://www.sology.eu](http://www.sology.eu)

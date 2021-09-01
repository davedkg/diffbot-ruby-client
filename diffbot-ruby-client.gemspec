# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'diffbot/api_client/version'

Gem::Specification.new do |spec|
  spec.name          = "diffbot-ruby-client"
  spec.version       = Diffbot::APIClient::VERSION::STRING
  spec.authors       = ['Diffbot']
  spec.email         = ['support@diffbot.com']
  spec.summary       = %q{Diffbot API Official gem.}
  spec.homepage      = 'https://github.com/diffbot/diffbot-ruby-client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec'

  spec.add_runtime_dependency 'faraday', '~> 0.17.3'
end

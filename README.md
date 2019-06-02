# Kutt.rb

[![Gem](https://img.shields.io/gem/v/kutt.svg?style=flat)](http://rubygems.org/gems/kutt "I', on RUBYGEMS")
[![Gem](https://img.shields.io/gem/dt/kutt.svg)](https://rubygems.org/gems/kutt)

A Ruby wrapper for kutt.it API

```
$ gem install kutt
```

To get an apikey you need to signup at kutt.it and generate API key from settings.

Check API response details at [Official repo](https://github.com/thedevs-network/kutt#api).
```ruby
require 'kutt'
k = Kutt.new 'apikey'
```

submit a new short url:
```ruby
# returns status code and object as hash or error
# `customurl`, `password`, `reuse` are optional
# set `reuse = true` to prevent duplicate shortend url for same link
k.submit("url", customurl="customurl", password="password", reuse=true)
```

list urls (5 by default):
```ruby
k.list # returns hash of urls list or error

k.list(20) # to list 20 urls
```

delete an url:
```ruby
k.delete("id or url") # returns message of success or error
```

stats of an specific url:
```ruby
k.stats("id or url") # returns link stats in detail or error
```

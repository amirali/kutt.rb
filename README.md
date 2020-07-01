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
# set `reuse: true` to prevent duplicate shortend url for the same link
k.submit("url", customurl: "customurl", password: "password", reuse: true)
```

list urls (5 by default, 50 Maximum):
```ruby
k.list # returns first 5 hash of urls list or error

# list(count = 5, page = 1)
k.list(50) # to list first 50 urls (50 Maximum)
k.list(50, 2) # to list second 50 urls (default value for page number is 1)
```

list all of urls (slow):
```ruby
k.list_all # returns all of urls
```

count number of links you created:
```ruby
k.count # returns in string fromat
```

delete an url:
```ruby
k.delete("id or url") # returns message of success or error
```

stats of an specific url:
```ruby
k.stats("id or url") # returns link stats in detail or error
```

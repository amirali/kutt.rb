# Kutt.rb
ruby library for work with kutt.it

```
$ gem install kutt
```

make a new kutt object with apikey (register and get that from https://kutt.it)
```ruby
require 'kutt'
k = Kutt.new 'apikey'
```

submit a new short url:
```ruby
k.submit("url", customurl="customurl", password="password", reuse=true) # customurl, password, reuse are optional | return status code and object as hash or error
```

list all urls:
```ruby
k.list # return hash of url list or error
```

delete an url:
```ruby
k.delete("id or url") # return message of success or error
```

stats of an url:
```ruby
k.stats("id or url") # return message of success or error
```

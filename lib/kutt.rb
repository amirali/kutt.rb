require 'httparty'
require 'json'

class Kutt
  def initialize(apikey)
    @base_url = 'https://kutt.it'
    @headers = { 'Content-Type': 'application/json', 'Accept': 'application/json',
       'X-API-Key': apikey}
    return true
  end

  def submit(url, **args)
    payload = {}
    payload['target'] =    url
    payload['customurl'] = args[:customurl] if args[:customurl]
    payload['password'] =  args[:password]  if args[:password]
    payload['reuse'] =     'true'           if args[:reuse] == true

    r = HTTParty.post(@base_url + '/api/url/submit',
      headers: @headers,
      body: payload.to_json)

    return r.code, r.to_hash
  end

  def delete(target)
    url_array = target.split("/")
    id = url_array.last

    payload = { 'id': id }

    r = HTTParty.post(@base_url + '/api/url/deleteurl', headers: @headers,
      body: payload.to_json)

    return r.code, r.to_hash
  end

  def stats(target)
    url_array = target.split('/')
    id = url_array.last

    payload = {'id': id}

    r = HTTParty.get(@base_url + '/api/url/stats',
      headers: @headers,
      query: payload)

    return r.code, r.to_hash
  end

  def count
    r = HTTParty.get(@base_url + '/api/url/geturls?count=0',
      headers: @headers)['countAll']
      return r
  end

  def list(count = 5)
    r = HTTParty.get(@base_url + '/api/url/geturls?count=' + count.to_s,
      headers: @headers)

    return r.code, r.to_hash
  end
end

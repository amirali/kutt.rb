require 'httparty'
require 'json'

class Kutt
  def initialize(apikey, base_url = 'https://kutt.it')
    @base_url = base_url
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
    url_array = target.split('/')
    id = url_array.last

    payload = { 'id': id }

    r = HTTParty.post(@base_url + '/api/url/deleteurl', headers: @headers,
      body: payload.to_json)

    return r.code, r.to_hash
  end

  def stats(target)
    url_array = target.split('/')
    id = url_array.last

    payload = {'id': id }

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

  def list(count = 5, page = 1)
    r = HTTParty.get(@base_url + "/api/url/geturls?count=#{count}&page=
      #{page}",
      headers: @headers)

    return r.code, r.to_hash
  end

  def list_all
    num_pages = (count.to_f / 50).ceil
    return ''.to_hash if num_pages.zero?

    full_list = []
    (1..num_pages).each do |page|
      r = HTTParty.get(@base_url + "/api/url/geturls?count=50&page=#{page}",
        :headers => @headers)['list']
      (full_list << r).flatten!
    end
    return r.code, full_list
  end
end

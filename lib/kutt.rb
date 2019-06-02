require 'httparty'
require 'json'

class Kutt
  def initialize(apikey)
    @base_url = 'https://kutt.it'
    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'X-API-Key' => apikey}
    return true
  end

  def submit(url, customurl=nil, password=nil, reuse=false)
    payload = {}
    payload['target'] = url
    if customurl
      payload['customurl'] = customurl
    end
    if password
      payload['password'] = password
    end
    if reuse
      payload['reuse'] = true
    end

    r = HTTParty.post(@base_url+'/api/url/submit',
      :headers => @headers,
      :body => payload.to_json)

    return r.code, r.to_hash
  end

  def delete(target)
    url_array = target.split("/")
    id = url_array.last
    
    payload = {'id' => id}
    
    r = HTTParty.post(@base_url+'/api/url/deleteurl',
      :headers => @headers,
      :body => payload.to_json)
    
    return r.code, r.to_hash
  end
  
  def stats(target)
    url_array = target.split("/")
    id = url_array.last
    
    payload = {'id' => id}
    
    r = HTTParty.get(@base_url+'/api/url/stats',
      :headers => @headers,
      :query => payload)
    
    return r.code, r.to_hash
  end
  
  def list(count = 5)
    r = HTTParty.get(@base_url+'/api/url/geturlsi?count='+count.to_s,
      :headers => @headers)
    
    return r.code, r.to_hash
  end
end

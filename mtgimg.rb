require 'sinatra'
require 'json'
require 'uri'

post '/' do
  text = params[:text].sub("mtgimg ", "")
	url = URI.parse("http://gatherer.wizards.com/Pages/Search/Default.aspx?name=+[#{text}]")
  req = Net::HTTP::Get.new(url.to_s)
  res = Net::HTTP.start(url.host, url.port) {|http|
    http.request(req)
  }
  {text: res.body}.to_json
end

get '/' do
  text = params[:text].sub("mtgimg ", "")
  url = URI.parse("http://gatherer.wizards.com/Pages/Search/Default.aspx?name=+[#{text}]")
  req = Net::HTTP::Get.new(url.to_s)
  res = Net::HTTP.start(url.host, url.port) {|http|
    http.request(req)
  }
  {text: res.body}.to_json
end
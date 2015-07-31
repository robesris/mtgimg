require 'sinatra'
require 'json'
require 'net/http'

post '/' do
  text = params[:text].sub("mtgimg ", "")
  url = URI.parse("http://gatherer.wizards.com/Pages/Search/Default.aspx?name=+[#{text}]")
  req = Net::HTTP::Get.new(url.to_s)
  res = Net::HTTP.start(url.host, url.port) {|http|
    http.request(req)
  }
  match = res.body.match(/multiverseid%3d([0-9]*)/)
  multiverseid = match[1]
  {text: multiverseid}.to_json
end

get '/' do
  puts "PARAMS: #{params}"
  puts "PARAMS[:TEXT]: #{params[:text]}"
  text = params[:text].sub("mtgimg ", "")
  url = URI.parse("http://gatherer.wizards.com/Pages/Search/Default.aspx?name=+[#{text}]")
  req = Net::HTTP::Get.new(url.to_s)
  res = Net::HTTP.start(url.host, url.port) {|http|
    http.request(req)
  }
  match = res.body.match(/multiverseid%3d([0-9]*)/)
  if match
    multiverseid = match[1]
    image_url = "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=#{multiverseid}&type=card"
    {text: image_url}.to_json
  else
    res.body
  end
end
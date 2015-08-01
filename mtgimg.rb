require 'sinatra'
require 'sinatra/multi_route'
require 'json'
require 'net/http'

route :get, :post, '/' do
  text = params[:text].sub("mtgimg ", "")
  text = text.split.inject(""){|str, word| "#{str}+[#{word}]"}
  url = URI.parse("http://gatherer.wizards.com/Pages/Search/Default.aspx?name=#{text}")
  req = Net::HTTP::Get.new(url.to_s)
  res = Net::HTTP.start(url.host, url.port) {|http|
    http.request(req)
  }
  match = res.body.match(/multiverseid%3d([0-9]*)/)
  match = res.body.match(/multiverseid[^0-9]*([0-9]*)/) unless match
  if match
    multiverseid = match[1]
    image_url = "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=#{multiverseid}&type=card"
    {text: image_url}.to_json
  else
    {text: "Sorry, something went wrong.  It's probably your fault! D:"}
  end
end

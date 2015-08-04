require 'sinatra'
require 'sinatra/multi_route'
require 'json'
require 'net/http'

def no_match_message(search_text)
  messages = [
    "Nice try.",
    "Seriously?",
    "I don't think so.",
    "Yes, there's a card named \"#{search_text}\".  No, really, there is.",
    "I'm going to tell Rob you're trying to mess with his bot.",
    "Nope.",
    "There's really not that many of these sarcastic messages.  You've probably seen them all already.  Also, your search returned no results."
  ]
  {text: messages.sample}.to_json
end

route :get, :post, '/' do
  text = params[:text].sub("mtgimg ", "")
  text = text.split.inject(""){|str, word| "#{str}+[#{word}]"}
  url = URI.parse("http://gatherer.wizards.com/Pages/Search/Default.aspx?name=#{text}")
  req = Net::HTTP::Get.new(url.to_s)
  res = Net::HTTP.start(url.host, url.port) {|http|
    http.request(req)
  }
  return no_match_message(params[:text]) if res.body.match(/Your search returned zero results/)

  match = res.body.match(/multiverseid%3d([0-9]*)/)
  match = res.body.match(/multiverseid[^0-9]*([0-9]*)/) unless match
  if match
    multiverseid = match[1]
    image_url = "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=#{multiverseid}&type=card"
    if request.post?
      {text: image_url}.to_json
    else
      "<html><img src='#{image_url}' /><html>"
    end
  else
    {text: "Sorry, something went wrong.  It's probably your fault! D:"}.to_json
  end
end

require 'sinatra'
require 'json'

post '/' do
  {text: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=87921&type=card"}.to_json
end
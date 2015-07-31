require 'sinatra'
require 'json'

post '/' do
  {text: "there"}.to_json
end
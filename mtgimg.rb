require 'sinatra'
require 'json'

get '/' do
  {text: "there"}.to_json
end
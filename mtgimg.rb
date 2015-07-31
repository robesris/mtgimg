require 'sinatra'
require 'json'

get '/' do
  {hello: "there"}.to_json
end
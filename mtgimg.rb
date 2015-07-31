require 'sinatra'
require 'json'

post '/' do
  {text: params.POST.text}.to_json
end
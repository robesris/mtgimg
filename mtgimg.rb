require 'sinatra'
require 'json'
require 'uri'

post '/' do
	#url = URI.parse("http://gatherer.wizards.com/Pages/Search/Default.aspx?name=+[#{params[:text]}]")
  {text: params[:text]}.to_json
end
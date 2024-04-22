require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  
@raw_response = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV['EXCHANGE_RATE_KEY']}")

erb(:homepage)
end

require "sinatra"
require "sinatra/reloader"

# Pull in the HTTP class
require "http"

# define a route for the homepage
get("/") do

  # Assemble the API url, including the API key in the query string
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

  # Use HTTP.get to retrieve the API data
  @raw_response = HTTP.get(api_url)

  # Get the body of the response as a string
  @string_response = @raw_response.to_s

  # Convert the string to JSON
  @parsed_response = JSON.parse(@string_response)

  @currencies = @parsed_response.fetch("currencies")
  # Render a view template
  erb(:homepage)
end

  get("/:first_symbol") do
      @the_symbol = params.fetch("first_symbol")

      # Assemble the API url, including the API key in the query string
      api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

      # Use HTTP.get to retrieve the API data
      @raw_response = HTTP.get(api_url)

      # Get the body of the response as a string
      @string_response = @raw_response.to_s

      # Convert the string to JSON
      @parsed_response = JSON.parse(@string_response)

      @currencies = @parsed_response.fetch("currencies")

    erb(:step_one)

end

get("/:first_symbol/:second_symbol") do

  @from = params.fetch("first_symbol")
  @to = params.fetch("second_symbol")
  @url= "https://api.exchangerate.host/convert?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY").chomp}&from=#{@from}&to=#{@to}&amount=1"

  @raw_response = HTTP.get(@url)
  @string_response = @raw_response.to_s
  @parsed_response = JSON.parse(@string_response)
  @amount = @parsed_response.fetch("result")


  erb(:step_two)
end

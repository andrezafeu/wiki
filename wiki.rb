require "sinatra"

get "/" do
  # the erb method returns the result as string
  erb :welcome
end
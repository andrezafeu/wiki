require "sinatra"

def page_content(title)
  File.read("pages/#{title}.txt")
# if the file is not found, raise exception
rescue Errno::ENOENT
  return nil
end

get "/" do
  # the erb method returns the result as string
  erb :welcome
end

get "/:title" do
  page_content(params[:title])
end
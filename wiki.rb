require "sinatra"

def page_content(title)
  File.read("pages/#{title}.txt")
# if the file is not found, raise exception
rescue Errno::ENOENT
  return nil
end

def save_content(title, content)
  File.open("pages/#{title}.txt", "w") do |file|
    file.print(content)
  end
end

def delete_content(title)
  File.delete("pages/#{title}.txt")
end

get "/" do
  # the erb method returns the result as string
  erb :welcome
end

get "/new" do
  # if we had different layouts for the app, we would specify it as erb :new, layout: :layout_name.erb
  erb :new
end

post "/create" do
  save_content(params[:title], params[:content])
  # get request to show the new page after it's saved
  redirect "/#{params[:title]}"
  
end

get "/:title" do
  @title = params[:title]
  @content = page_content(@title)
  erb :show
end

get "/:title/edit" do
  @title = params[:title]
  @content = page_content(@title)
  erb :edit
end

put "/:title" do
  save_content(params[:title], params[:content])
  redirect "/#{params[:title]}"
end

delete "/:title" do
  delete_content(params[:title])
  redirect "/"
end
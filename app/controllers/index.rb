get '/' do
  # Look in app/views/index.erb
  # @new_url = params[:new_url]
  erb :index
end

get '/:short_url' do
  @url = Url.find_by_short_url(params[:short_url])
  @url.increment!(:counter)
  redirect to "http://#{@url.full_url}"
end


post '/create_short' do
  
  if Url.create(params).valid?
  
    @new_url = "localhost:9393/" + Url.last.short_url

  else
    @new_url = "Please Enter Valid URL"
  end
  
  erb :index

end


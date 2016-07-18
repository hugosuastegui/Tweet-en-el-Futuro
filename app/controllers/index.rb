get '/' do
  erb :index
end

post '/fetch' do 
  @twitter_handle = params[:twitter_handle]
  redirect to  ("/#{@twitter_handle}")
end

get '/:handle' do 
  @twitter_handle = params[:handle]
  user = TwitterUser.find_or_create_by(name: @twitter_handle)
  Tweet.base(@twitter_handle)
  @all_tweets = Tweet.where(user_id: user.id)
  erb :secret
end


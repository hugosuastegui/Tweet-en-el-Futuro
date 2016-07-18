
get '/' do
  erb :index
end

post '/fetch' do 
  @twitter_handle = params[:twitter_handle]
  redirect to  ("/#{@twitter_handle}")
end

post '/tweet' do
  tweet = params[:tweet_content2]
  # user = TwitterUser.find_or_create_by(name: @twitter_handle)
  @user_tweet = TCLIENT.update(tweet)
  @user_tweet.text
end

get '/:handle' do 
  @twitter_handle = params[:handle]
  user = TwitterUser.find_or_create_by(name: @twitter_handle)
  Tweet.base(@twitter_handle)
  @all_tweets = Tweet.where(user_id: user.id)
  erb :secret
end


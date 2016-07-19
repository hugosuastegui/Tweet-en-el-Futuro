class TwitterUser < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets
  
  def novo(tweet)
    nclient = Twitter::REST::Client.new do |config|
      config.consumer_key         = ENV['TWITTER_KEY']
      config.consumer_secret      = ENV['TWITTER_SECRET']
      config.access_token         = self.oauth_token
      config.access_token_secret  = self.oauth_token_secret
    end
    user_tweet = nclient.update(tweet)
    user_tweet.text
  end
    

end

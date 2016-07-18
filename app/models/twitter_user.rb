class TwitterUser < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets
  
  def self.novo(oauth_token, oauth_token_secret)
    TCLIENT = Twitter::REST::Client.new do |config|
      config.consumer_key     = ENV['TWITTER_KEY']
      config.consumer_secret  = ENV['TWITTER_SECRET']
      config.access_token     = oauth_token
      config.access_token     = oauth_token_secret
  end
    
end

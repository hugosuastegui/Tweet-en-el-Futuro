class Tweet < ActiveRecord::Base
  # Remember to create a migration!
  def self.base(user)
    twitter_user = TwitterUser.find_by(name: user)
    twitter_user_id = twitter_user.id
    user_tweets = TCLIENT.user_timeline(user).take(20)
    user_tweets.each{|tweet| Tweet.create(user_id: twitter_user_id, content: tweet.text)}
  end
end

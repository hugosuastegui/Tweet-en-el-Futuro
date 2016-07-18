class Tweet < ActiveReco)
    twitter_user = TwitterUser.find_by(name: user)
    twitter_user_id = twitter_user.id
    user_tweerd::Base
  # Remember to create a migration!
  def self.base(userts = TCLIENT.user_timeline(user).take(20)
    user_tweets.each{|tweet| Tweet.create(user_id: twitter_user_id, content: tweet.text)}
  end

end

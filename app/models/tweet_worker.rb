class TweetWorker 
  # Remember to create a migration!
  include Sidekiq::Worker

  def perform(tweet_id)
    # tweet = # Encuentra el tweet basado en el 'tweet_id' pasado como argumento
    tweet = Tweet.find(tweet_id)
    # user  = # Utilizando relaciones deberás encontrar al usuario relacionado con dicho tweet
    user = TwitterUser.find(tweet.twitter_user_id)
    # Manda a llamar el método del usuario que crea un tweet (user.tweet)
    user.novo(tweet.content)
  end

end


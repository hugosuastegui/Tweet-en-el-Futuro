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
    
  def tweet_later(text,num)
    # tweet = # Crea un tweet relacionado con este usuario en la tabla de tweets
    tweet = Tweet.first_or_create(content: text, twitter_user_id: self.id)
    # Este es un método de Sidekiq con el cual se agrega a la cola una tarea para ser 
    # jid = TweetWorker.perform_async(tweet.id)
    jid = TweetWorker.perform_in(num.seconds,tweet.id)
    #La última linea debe de regresar un sidekiq job id
    tweet.update(job_id: jid)
  end


end

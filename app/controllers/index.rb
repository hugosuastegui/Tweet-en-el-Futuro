
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
  # @user_tweet = TCLIENT.update(tweet)
  # @user_tweet.text
  # @current_user.novo(tweet)
  p current_user
  current_user.novo(tweet)
end


get '/sign_in' do
  # El método `request_token` es uno de los helpers
  # Esto lleva al usuario a una página de twitter donde sera atentificado con sus credenciales
  # p  request_token.authorize_url(:oauth_callback => "http://#{host_and_port}/auth")
  redirect request_token.authorize_url(:oauth_callback => "http://#{host_and_port}/auth")
  # Cuando el usuario otorga sus credenciales es redirigido a la callback_url 
  # Dentro de params twitter regresa un 'request_token' llamado 'oauth_verifier'

end

get '/auth' do
  # Volvemos a mandar a twitter el 'request_token' a cambio de un 'acces_token' 
  # Este 'acces_token' lo utilizaremos para futuras comunicaciones.   
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  p  @access_token
  # Despues de utilizar el 'request token' ya podemos borrarlo, porque no vuelve a servir. 
  session.delete(:request_token)
  # Aquí es donde deberás crear la cuenta del usuario y guardar usando el 'acces_token' lo siguiente:
  # nombre, oauth_token y oauth_token_secret
  p screen_name = @access_token.params[:screen_name]
  p oauth_token = @access_token.params[:oauth_token]
  p oauth_token_secret = @access_token.params[:oauth_token_secret]
  # No olvides crear su sesión 
  if user = TwitterUser.find_by(name: screen_name)
    user.update(oauth_token: oauth_token, oauth_token_secret: oauth_token_secret)
    session[:user_id] = user.id
  else 
    user = TwitterUser.create(name: screen_name, oauth_token: oauth_token, oauth_token_secret: oauth_token_secret)
    session[:user_id] = user.id
  end
  erb :index
end

get '/logout' do 

  session.destroy 
  erb :index
end

get '/:handle' do 
  @twitter_handle = params[:handle]
  user = TwitterUser.find_or_create_by(name: @twitter_handle)
  Tweet.base(@twitter_handle)
  @all_tweets = Tweet.where(user_id: user.id)
  erb :secret
end
  # Para el signout no olvides borrar el hash de session

before '/secret' do
  if session[:email]
    erb :secret
  else
    erb :logout
  end

end


get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  session.clear
  erb :index
  
end

get '/register_temp' do

  erb :register

end

get '/login_temp' do
  erb :login
end

get '/secret' do 
  erb :secret
end

get '/logout' do 
  session.clear
  erb :index
  end




post '/registro' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  @user_name = params[:Usuario]
  # p @user_name
  @user_mail = params[:Mail]
  # p @user_mail
  @user_pass = params[:Contraseña]
  # p @user_pass

  User.create(usuario: @user_name, mail: @user_mail, password: @user_pass)

  erb :index
end

post '/login' do

  @user_mail = params[:Mail]
  # p @user_mail
  @user_pass = params[:Contraseña]
  # p @user_pass
  val_user = User.authenticate(@user_mail, @user_pass)
  # p @val_user
  if val_user
    session[:email] = val_user.mail
    session[:user_name] = val_user.usuario
    redirect to '/secret' 
  else
    session[:error_message] = "No son correctos tus datos"
    redirect to '/login_temp'
  end


end


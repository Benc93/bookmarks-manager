class BookmarkManager

  post '/users' do
     @user = User.new(:email => params[:email],
                :password => params[:password],
                :password_confirmation => params[:password_confirmation])
     if @user.save
      session[:user_id] = @user.id
      redirect to('/')
     else
      flash.now[:errors] = @user.errors.full_messages
      erb :"users/new"
     end
    end

  get '/users/forgot_password' do
    erb :"users/forgot_password"
  end

  post '/users/forgot_password' do
    user = User.first(email: params[:email])
    user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
    user.save
    mg_client = Mailgun::Client.new ENV['MY_MAILGUN_KEY']

    # Define your message parameters
    message_params = {:from    => ENV['MAILGUN_POSTMASTER'],
                      :to      => user.email,
                      :subject => 'Forgotten password',
                      :text    => "Please visit http://localhost:9292/users/reset_password/#{user.password_token}"}
    # Send your message through the client
    mg_client.send_message ENV['MAILGUN_DOMAIN'], message_params
    'Please check your e-mail'
  end

  get '/users/reset_password/:token' do
    @token = params[:token]
    user = User.first(password_token: @token)
    erb :"users/reset_password"
  end

  post '/users/reset_password' do
    @token = params[:password_token]
    user = User.first(password_token: @token)
    user.update(password: params[:password], password_token: nil)

    flash[:notice] = "Password successfully reset"
    redirect '/'
  end

end
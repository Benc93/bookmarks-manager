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
      'display a form where I can fill in my email'
    end

end
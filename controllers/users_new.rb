class BookmarkManager

  get '/users/new' do
   @user = User.new
   erb :"users/new"
  end

end
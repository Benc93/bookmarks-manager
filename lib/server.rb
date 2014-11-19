require 'sinatra/base'
require 'data_mapper'
require './lib/link'


class BookmarkManager < Sinatra::Base
  
  get '/' do
  @links = Link.all
  erb :index
  end



env = ENV['RACK_ENV'] || 'development'

# we're telling datamapper to use a postgres database on localhost. The name will be "bookmark_manager_test" or "bookmark_manager_development" depending on the environment
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

 # this needs to be done after datamapper is initialised

# After declaring your models, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!



  # start the server if ruby file executed directly
  run! if app_file == $0
end



require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './lib/link'
require './lib/tag'
require './lib/user'
require './app/helpers/helpers'

DataMapper.finalize
DataMapper.auto_upgrade!


class BookmarkManager < Sinatra::Base

  include Helpers
  use Rack::Flash
  use Rack::MethodOverride

  configure do 
   register Sinatra::Partial
   set :partial_template_engine, :erb
  end

  enable :sessions
  set :session_secret, 'super secret'
  



  run! if app_file == $0

end

require './controllers/homepage'
require './controllers/links'
require './controllers/tags'
require './controllers/users_new'
require './controllers/users'
require './controllers/sessions_new'
require './controllers/sessions'
require './controllers/delete_sessions'



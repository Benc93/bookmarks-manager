require 'sinatra/base'

class BookmarksManager < Sinatra::Base
  get '/' do
    'Hello BookmarksManager!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

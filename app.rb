require 'sinatra/base'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override

  get '/' do
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    erb :bookmarks
  end

  get '/bookmarks/add' do
    erb :add_bookmark
  end

  post '/bookmarks' do
    url = params[:url]
    title = params[:title]
    Bookmark.create(title, url)
    erb :bookmarks
    p ENV
  end

  delete '/bookmarks/:id' do
    redirect '/bookmarks'
  end

  run! if app_file == $0

end

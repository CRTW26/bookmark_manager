require 'sinatra/base'
require_relative './lib/bookmark.rb'
require_relative './lib/database_connection.rb'
require './lib/database_connection_setup.rb'


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
    Bookmark.create(params[:title], params[:url])
    erb :bookmarks
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/edit/:id' do
    @params = params[:id]
    erb :update
  end

  patch '/bookmarks/:id' do
    Bookmark.update(params[:id], params[:title], params[:url])
    redirect '/bookmarks'
  end

  run! if app_file == $0

end

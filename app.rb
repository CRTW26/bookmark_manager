require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/bookmark.rb'
require_relative './lib/database_connection.rb'
require './lib/database_connection_setup.rb'


class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override
  register Sinatra::Flash
  
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
    if params[:url] =~ /\A#{URI::regexp(['http', 'https'])}\z/
      Bookmark.create(params[:title], params[:url])
    else
        flash[:notice] = "Invalid URL"
    end 
    redirect '/bookmarks'
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

  get '/bookmarks/new_comment/:id' do
    @id = params[:id]
    erb :add_comment
  end

  post '/bookmarks/new_comment/:id' do
    Bookmark.comment(@id, params[:comment])
    redirect '/bookmarks'
  end

  run! if app_file == $0

end

require 'pg'
require_relative './database_connection'

class Bookmark 

  attr_reader :id, :title, :url, :connection

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    Bookmark.set_environment
    result = DatabaseConnection.query("SELECT * FROM bookmarks")
    result.map do |bookmark|
      Bookmark.new(
        url: bookmark['url'],
        title: bookmark['title'],
        id: bookmark['id']
      )
    end
  end

  def self.create(title, url)
    Bookmark.set_environment

    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url;")
    
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id)
    Bookmark.set_environment
    @connection = DatabaseConnection.connection

    @connection.exec("DELETE FROM bookmarks WHERE id = #{id}")
  end   
  
  def self.update(id, title, url)
    Bookmark.set_environment
    result = @connection.exec("UPDATE bookmarks SET title = '#{title}', url = '#{url}' WHERE id= #{id} RETURNING id, title, url;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.set_environment
    if ENV['ENVIRONMENT'] == 'test'
      DatabaseConnection.setup('bookmark_manager_test')
    else
      DatabaseConnection.setup('bookmark_manager')
    end
  end

  def self.comment(id, comment)
    Bookmark.set_environment
    @connection = DatabaseConnection.connection

    @connection.exec("INSERT INTO comments (text, bookmark_id) VALUES('#{comment}', #{id});")
  end

end

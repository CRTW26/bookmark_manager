require 'pg'

def truncates
  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.exec('TRUNCATE TABLE bookmarks')
end

def persisted_data(id:)
  connection = PG.connect(dbname: 'bookmark_manager_test')
  result = connection.query("SELECT * FROM bookmarks WHERE id = #{id};")
  result.first
end


def add_urls
  Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
  Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')
  Bookmark.create(url: 'http://www.google.com', title: 'Google')
end

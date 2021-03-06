require 'bookmark'
require 'database_connection'
require 'database_helpers'

describe '.all' do
  it 'returns a list of bookmarks' do
    @connection = DatabaseConnection.setup('bookmark_manager')
 
    bookmark = Bookmark.create('Makers Academy', 'http://www.makersacademy.com')
    Bookmark.create("Destroy All Software", "http://www.destroyallsoftware.com")
    Bookmark.create("Google", "http://www.google.com")
 
    bookmarks = Bookmark.all
    
    expect(bookmarks.length).to eq 3
    expect(bookmarks.first).to be_a Bookmark
    expect(bookmarks.first.id).to eq bookmark.id
    expect(bookmarks.first.title).to eq 'Makers Academy'
    expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
   end
 end

 describe '.create' do
  it 'creates a new bookmark' do
    bookmark = Bookmark.create('Test Bookmark', 'http://www.testbookmark.com')
    persisted_data = persisted_data(id: bookmark.id)

    expect(bookmark).to be_a Bookmark
    expect(bookmark.id).to eq persisted_data['id']
    expect(bookmark.title).to eq 'Test Bookmark'
    expect(bookmark.url).to eq 'http://www.testbookmark.com'
  end

  describe '.delete' do 
    it 'deletes a bookmark' do
      bookmark = Bookmark.create('Test Bookmark', 'http://www.testbookmark.com')
      Bookmark.delete(bookmark.id)
      expect(Bookmark.all.length).to eq 0 
    end
  end

  describe '.update' do
    it 'updates the title and url of a bookmark' do 
      bookmark = Bookmark.create('http://www.testbookmark.com', 'Test Bookmark')
      persisted_data = persisted_data(id: bookmark.id)
      bookmark = Bookmark.update(persisted_data['id'], 'To see if test works', 'http://www.toseeiftestworks.com')
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'To see if test works'
      expect(bookmark.url).to eq 'http://www.toseeiftestworks.com'
    end
  end 
end

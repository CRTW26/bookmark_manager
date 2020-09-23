require 'databaseconnection' 

describe DatabaseConnection do
  describe '#setup' do
    it 'takes on parameter' do
      expect(DatabaseConnection).to respond_to(:setup).with(1).argument
    end

    it 'sets up a connection to a database and sets it to an instance variable' do
      db = DatabaseConnection.setup('bookmark_manager')
      expect(db).to be_kind_of(PG::Connection)
    end
  end

  describe '#query' do
    db = DatabaseConnection.setup('bookmark_manager')

    it 'takes one parameter, an SQL query string' do
      expect(DatabaseConnection).to respond_to(:query).with(1).argument
    end

    it 'executes an SQL query on the database linked to by @connection' do
      query = "SELECT * FROM bookmarks"
      expect(db.query(query)).to be_kind_of(PG::Result)
    end

  end

end
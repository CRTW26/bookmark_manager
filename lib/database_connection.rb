require 'pg'

class DatabaseConnection
  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname)
  end

  def self.connection
    @connection
  end

  def self.query(sql)
    @connection.exec(sql)
  end

  # def self.check
  #   if ENV['ENVIRONMENT'] == 'test'
  #     DatabaseConnection.setup('bookmark_manager_test')
  #   else
  #     DatabaseConnection.setup('bookmark_manager')
  #   end
  # end
end

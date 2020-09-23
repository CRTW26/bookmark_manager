class DatabaseConnection

  #attr_accessor :connection

  def self.setup(dbname)
    if ENV['ENVIRONMENT'] == 'test'
      @connection = PG.connect(dbname: "#{dbname}_test")
    else
      @connection = PG.connect(dbname: "#{dbname}")
    end
  end

  def self.query(query)
    @connection.exec(query)
  end

end

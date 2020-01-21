require('pg')
class Property

  attr_accessor :address, :value, :bedrooms, :status
  attr_reader :id
  def initialize(options)
    @address = options['address']
    @value = options['value']
    @bedrooms = options['bedrooms']
    @status = options['status']
    @id = options['id'].to_i if options['id']
  end


  def save()
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "INSERT INTO properties
    (address, value, bedrooms, status)VALUES ($1, $2, $3, $4) RETURNING *"
    values = [@address, @value, @bedrooms, @status]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def Property.all()
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    prop = db.exec_prepared("all")
    db.close()
    return prop.map{|prope| Property.new(prope)}
  end

  def Property.delete_all()
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "DELETE FROM properties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end


  def delete()
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "DELETE FROM properties WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def update()
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "UPDATE properties SET(address, value, bedrooms,status)
    = ($1, $2, $3, $4 ) WHERE id = $5"
    values = [@address, @value, @bedrooms, @status, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end


  #####

  # def Property.find(id)
  #   db = PG.connect({dbname: 'properties', host: 'localhost'})
  #   sql = "SELECT * FROM properties WHERE id = #{id}"
  #   db.prepare("find", sql)
  #   prop = db.exec_prepared("find")
  #   db.close()
  #   return prop.map{|prope| Property.new(prope)}
  # end

  ####
  # def find_by_id()
  #   db = PG.connect({dbname: 'properties', host: 'localhost'})
  #   sql = "SELECT * FROM properties WHERE id = $1"
  #   values = [@id]
  #   db.prepare("find", sql)
  #   db.exec_prepared("find", values)
  #   db.close
  # end

  def Property.find(category, category_value)
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE #{category} = '#{category_value}'"
    db.prepare("find", sql)
    prop = db.exec_prepared("find")
    db.close()
    return prop.map{|prope| Property.new(prope)}
  end

end

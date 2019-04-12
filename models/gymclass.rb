require_relative('../db/sql_runner.rb')

class GymClass
  
  attr_reader :id, :name
  
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end
  
  def save()
    sql = "INSERT INTO classes (name) VALUES ($1) RETURNING id"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end
  
  def view()
    sql = "SELECT * FROM classes WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)[0]
    return GymClass.new(result)
  end
  
  def list_all()
    sql = "SELECT * FROM classes"
    results = SqlRunner.run(sql)
    return results.map { |gymclass| GymClass.new(gymclass) }
  end
  
  def update()
    sql = "UPDATE classes (name) = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end
  
  def delete()
    sql = "REMOVE FROM classes WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
  
  def self.delete_all()
    sql = "REMOVE FROM classes"
    SqlRunner.run(sql)
  end
  
end

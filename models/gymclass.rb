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
  
  def self.view(id)
    sql = "SELECT * FROM classes WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    return GymClass.new(result)
  end
  
  def self.list_all()
    sql = "SELECT * FROM classes"
    results = SqlRunner.run(sql)
    return results.map { |gymclass| GymClass.new(gymclass) }
  end
  
  def update()
    sql = "UPDATE classes SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end
  
  def delete()
    sql = "DELETE FROM classes WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
  
  def self.delete_all()
    sql = "DELETE FROM classes"
    SqlRunner.run(sql)
  end
  
  def list_members()
    sql = "SELECT members.* FROM members INNER JOIN bookings ON members.id = bookings.member_id WHERE class_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values).uniq
    return results.map{ |member| Member.new(member) }
  end
  
end

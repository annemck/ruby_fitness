require_relative('../db/sql_runner.rb')

class GymClass
  
  attr_reader :id, :name, :day, :start_time, :duration
  
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @day = options['day']
    @start_time = options['start_time']
    @duration = options['duration']
  end
  
  def save()
    sql = "INSERT INTO classes (name, day, start_time, duration) VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@name, @day, @start_time, @duration]
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
    sql = "UPDATE classes SET (name, day, start_time, duration) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@name, @day, @start_time, @duration, @id]
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

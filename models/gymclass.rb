require_relative('../db/sql_runner.rb')

class GymClass
  
  attr_reader :id, :name, :day, :start_time, :duration, :max_capacity, :booked_spaces
  
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @day = options['day']
    @start_time = options['start_time']
    @duration = options['duration']
    @max_capacity = options['max_capacity'].to_i
    @booked_spaces = options['booked_spaces'].to_i if options['booked_spaces']
  end
  
  def save()
    sql = "INSERT INTO classes (name, day, start_time, duration, max_capacity, booked_spaces) VALUES ($1, $2, $3, $4, $5, 0) RETURNING id"
    values = [@name, @day, @start_time, @duration, @max_capacity]
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
    sql = "UPDATE classes SET (name, day, start_time, duration, max_capacity, booked_spaces) = ($1, $2, $3, $4, $5, $6) WHERE id = $7"
    values = [@name, @day, @start_time, @duration, @max_capacity, @booked_spaces, @id]
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
  
  def increase_booked_spaces()
    @booked_spaces += 1
  end
  
  def space_left()
    value = @max_capacity - @booked_spaces
    return value
  end
  
  def decrease_booked_spaces()
    @booked_spaces -= 1
  end
  
end

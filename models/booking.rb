require_relative('../db/sql_runner.rb')

class Booking
  
  attr_reader :id, :member_id, :class_id
  
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @member_id = options['member_id'].to_i
    @class_id = options['class_id'].to_i
  end
  
  def save()
    sql = "INSERT INTO bookings (member_id, class_id) VALUES ($1, $2) RETURNING id"
    values = [@member_id, @class_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end
  
  def self.view(booking_id)
    sql = "SELECT * FROM bookings WHERE id = $1"
    values = [booking_id]
    result = SqlRunner.run(sql, values)[0]
    return Booking.new(result)
  end
  
  def self.list_all()
    sql = "SELECT * FROM bookings"
    results = SqlRunner.run(sql)
    return results.map { |booking| Booking.new(booking) }
  end
  
  def update()
    sql = "UPDATE bookings SET (member_id, class_id) = ($1, $2) WHERE id = $3"
    values = [@member_id, @class_id, @id]
    SqlRunner.run(sql, values)
  end
  
  def delete()
    sql = "DELETE FROM bookings WHERE id = $1"
    values =[@id]
    SqlRunner.run(sql, values)
  end
  
  def self.delete_all()
    sql = "DELETE FROM bookings"
    SqlRunner.run(sql)
  end
  
  def find_class()
    sql = "SELECT classes.* FROM classes WHERE id = $1"
    values = [@class_id]
    gymclass = SqlRunner.run(sql, values)[0]
    return GymClass.new(gymclass)
  end
  
  def find_members()
    sql = "SELECT members.* FROM members INNER JOIN bookings ON members.id = bookings.member_id WHERE bookings.class_id = $1"
    values = [@class_id]
    members = SqlRunner.run(sql, values).uniq
    return members.map { |member| Member.new(member) }
  end
  
  def find_single_member()
    sql = "SELECT * FROM members WHERE id = $1"
    values = [@member_id]
    member = SqlRunner.run(sql, values)[0]
    return Member.new(member)
  end
  
end

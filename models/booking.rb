require_relative('../db/sql_runner.rb')

class Booking
  
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
  
  def view()
    sql = "SELECT * FROM bookings WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)[0]
    return Booking.new(result)
  end
  
  def list_all()
    sql = "SELECT * FROM bookings"
    results = SqlRunner.run(sql)
    return results.map { |booking| Booking.new(booking) }
  end
  
  def update()
    sql = "UPDATE bookings SET (member_id, class_id) = ($1, $2)"
    values = [@member_id, @class_id]
    SqlRunner.run(sql, values)
  end
  
  def delete()
    sql = "REMOVE FROM bookings WHERE id - $1"
    values =[@id]
    SqlRunner.run(sql, values)
  end
  
  def self.delete_all()
    sql = "REMOVE FROM bookings"
    SqlRunner.run(sql)
  end
  
end

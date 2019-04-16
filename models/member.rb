require_relative('../db/sql_runner.rb')
require_relative('booking.rb')
require_relative('gymclass.rb')

class Member
  
  attr_reader :id, :first_name, :last_name, :join_date, :membership_type
  
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @join_date = options['join_date']
    @membership_type = options['membership_type']
  end
  
  def save()
    sql = "INSERT INTO members
          (first_name, last_name, join_date, membership_type)
          VALUES ($1, $2, $3, $4)
          RETURNING id"
    values = [@first_name, @last_name, @join_date, @membership_type]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end
  
  def self.view(id)
    sql = "SELECT * FROM members WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    return Member.new(result)
  end
  
  def self.list_all()
    sql = "SELECT * FROM members"
    results = SqlRunner.run(sql)
    return results.map{ |member| Member.new(member) }
  end
  
  def update()
    sql = "UPDATE members SET (first_name, last_name, join_date, membership_type) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@first_name, @last_name, @join_date, @membership_type, @id]
    SqlRunner.run(sql, values)
  end
  
  def delete()
    sql = "DELETE FROM members WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
  
  def self.delete_all()
    sql = "DELETE FROM members"
    SqlRunner.run(sql)
  end
  
  def find_bookings()
    sql = "SELECT classes.* FROM classes INNER JOIN bookings ON classes.id = bookings.class_id WHERE bookings.member_id = $1 ORDER BY ID DESC LIMIT 3;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |booked_class| GymClass.new(booked_class) }
  end
  
  def find_all_bookings()
    sql = "SELECT * FROM bookings WHERE member_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{ |booking| Booking.new(booking) }
  end
  
  def times_class_taken(gymclass)
    sql = "SELECT bookings.* FROM bookings WHERE member_id = $1 AND class_id = $2"
    values = [@id, gymclass.id]
    results = SqlRunner.run(sql, values)
    mapped_results = results.map{ |booking| Booking.new(booking)}
    return mapped_results.count()
  end
  
  
end

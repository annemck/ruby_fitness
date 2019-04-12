require_relative('../db/sql_runner.rb')

class Member
  
  attr_accessor :id, :first_name, :last_name, :join_date, :membership_type
  
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @join_date = options['join_date']
    @membership_type = options['membership_type']
  end
  
  def save()
    sql = "INSERT INTO members (first_name, last_name, join_date, membership_type) VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@first_name, @last_name, @join_date, @membership_type]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end
  
  def view()
    sql = "SELECT * FROM members WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)[0]
    return Member.new(result)
  end
  
  def self.list_all()
    sql = "SELECT * FROM members"
    results = SqlRunner.run(sql)
    return results.map{ |member| Member.new(member) }
  end
  
  def update()
    sql = "UPDATE members (first_name, last_name, join_date, membership_type) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@first_name, @last_name, @join_date, @membership_type, @id]
    SqlRunner.run(sql, values)
  end
  
  def delete()
    sql = "REMOVE FROM members WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
  
  def self.delete_all()
    sql = "REMOVE FROM members"
    SqlRunner.run(sql)
  end
  
  
end

require_relative('../models/member.rb')
require('pry-byebug')
require('minitest/autorun')
require('minitest/rg')



class TestMembers < MiniTest::Test

def setup
  @member1 = Member.new({'first_name' => 'Joe', 'last_name' => 'Blogs', 'join_date' => '03/01/2018', 'membership_type' => 'Gym & Classes'})
end

def test_member_has_first_name
  assert_equal('Joe', @member1.first_name)
end

def test_member_has_last_name
  assert_equal('Blogs', @member1.last_name)
end

def test_member_has_join_date
  assert_equal('03/01/2018', @member1.join_date)
end

def test_membership_type
  assert_equal('Gym & Classes', @member1.membership_type)
end


end

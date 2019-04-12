require_relative('../models/gymclass.rb')
require('minitest/autorun')
require('minitest/rg')

class TestGymClass < MiniTest::Test
  
  def setup
    @gymclass1 = GymClass.new({'id' => 1, 'name' => 'Kettlebells'})
  end
  
  def test_gymclass_has_name
    assert_equal('Kettlebells', @gymclass1.name)
  end
  
end

require_relative('../models/booking.rb')
require_relative('../models/gymclass.rb')
require_relative('../models/member.rb')
require('pry')

member1 = Member.new({'first_name' => 'Joe', 'last_name' => 'Fields', 'join_date' => '23/09/2018', 'membership_type' => 'Premium Membership'})
member1.save()

member2 = Member.new({'first_name' => 'Rachel', 'last_name' => 'Green', 'join_date' => '03/01/2017', 'membership_type' => 'Gym Only'})
member2.save()

gymclass1 = GymClass.new({'name' => 'Kettlebells', 'day' => 'Wednesday', 'start_time' => '18:00', 'duration' => '45 mins', 'max_capacity' => 2})
gymclass1.save()

booking1 = Booking.new({'member_id' => member1.id, 'class_id' => gymclass1.id})
booking1.save()

gymclass2 = GymClass.new({'name' => 'Zumba', 'day' => 'Monday', 'start_time' => '19:00', 'duration' => '60 mins', 'max_capcity' => 30})
gymclass2.save()

booking2 = Booking.new({'member_id' => member1.id, 'class_id' => gymclass2.id})
booking2.save()

new_gymclass = GymClass.new(({'name' => 'Zumba', 'day' => 'Saturday', 'start_time' => '12:00', 'duration' => '45 mins', 'max_capacity' => 30}))
new_gymclass.save()

new_bookings = Booking.new({'member_id' => member1.id, 'class_id' => new_gymclass.id})
new_bookings.save()

gymclass3 = GymClass.new({'name' => 'Pound', 'day' => 'Tuesday', 'start_time' => '11:30', 'duration' => '45 mins', 'max_capacity' => 25})
gymclass3.save()

gymclass4 = GymClass.new({'name' => 'Yoga', 'day' => 'Saturday', 'start_time' => '09:00', 'duration' => '60 mins', 'max_capacity' => 20})
gymclass4.save()

booking3 = Booking.new({'member_id' => member1.id, 'class_id' => gymclass3.id})
booking3.save()

booking4 = Booking.new({'member_id' => member1.id, 'class_id' => gymclass4.id})
booking4.save()

booking5 = Booking.new({'member_id' => member1.id, 'class_id' => gymclass1.id})
booking5.save()

member3 = Member.new({'first_name' => 'Ross', 'last_name' => 'Geller', 'join_date' => '01/01/2019', 'membership_type' => 'Gym & Classes'})
member3.save()

booking6 = Booking.new({'member_id' => member3.id, 'class_id' => gymclass1.id})
booking6.save()

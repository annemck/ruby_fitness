require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/booking.rb')
require_relative('../models/gymclass.rb')
require_relative('../models/member.rb')
require('pry')


get '/bookings/all' do
  @bookings = Booking.list_all()
  erb(:"bookings/index")
end

get '/bookings/new' do
  erb(:"bookings/new")
end

get '/bookings/new/:id' do
  @viewed_class = GymClass.view(params[:id].to_i)
  erb(:"bookings/new")
end

get '/bookings/member/:id' do
  @member = Member.view(params[:id].to_i)
  erb(:"bookings/view")
end

get '/bookings/:id/update' do
  @booking = Booking.view(params[:id].to_i)
  @member = @booking.find_single_member()
  erb(:"bookings/edit")
end

get '/bookings/:id' do
  @booking = Booking.view(params[:id].to_i)
  @member = @booking.find_single_member()
  @gymclass = @booking.find_class()
  erb(:"bookings/show")
end

post '/bookings/new' do
  booking = Booking.new(params)
  booking.save()
  gymclass = booking.find_class()
  gymclass.increase_booked_spaces()
  gymclass.update()
  redirect to("/bookings/#{booking.id}")
end

post '/bookings/:id/update' do
  old_booking = Booking.view(params[:id])
  old_class = old_booking.find_class()
  old_class.decrease_booked_spaces()
  old_class.update()
  booking = Booking.new(params)
  booking.update()
  gymclass = booking.find_class()
  gymclass.increase_booked_spaces()
  gymclass.update()
  redirect to("/bookings/#{booking.id}")
end

post '/bookings/:id/delete' do
  booking = Booking.view(params[:id].to_i)
  booking.delete()
  gymclass = booking.find_class()
  gymclass.decrease_booked_spaces()
  gymclass.update()
  redirect to("/bookings/all")
end

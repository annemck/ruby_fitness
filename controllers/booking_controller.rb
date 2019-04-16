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
  redirect to("/bookings/#{booking.id}")
end

post '/bookings/:id/update' do
  booking = Booking.new(params)
  booking.update()
  redirect to("/bookings/#{booking.id}")
end

post '/bookings/:id/delete' do
  booking = Booking.view(params[:id].to_i)
  booking.delete()
  redirect to("/bookings/all")
end
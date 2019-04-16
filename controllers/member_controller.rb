require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/member.rb')
require_relative('../models/booking.rb')

get '/members/all' do
  @members = Member.list_all()
  erb(:"members/index")
end

get '/members/new' do
  erb(:"members/new")
end

get '/members/:id/update' do
  @member = Member.view(params[:id].to_i)
  erb(:"members/edit")
end

get '/members/:id' do
  @member = Member.view(params[:id].to_i)
  erb(:"members/show")
end

post '/members/all' do
  member = Member.new(params)
  member.save()
  redirect to("/members/#{member.id}")
end

post '/members/:id/update' do
  member = Member.new(params)
  member.update()
  redirect to("/members/#{member.id}")
end

post '/members/:id' do
  member = Member.view(params[:id].to_i)
  member.delete()
  redirect to('/members/all')
end

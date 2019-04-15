require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/gymclass.rb')
also_reload('models/*')

get '/classes/all' do
  @gymclasses = GymClass.list_all()
  erb(:"gymclass/index")
end

get '/classes/new' do
  erb(:"gymclass/new")
end

get '/classes/:id/update' do
  @gymclass = GymClass.view(params[:id].to_i)
  erb(:"gymclass/edit")
end

get '/classes/:id' do
  @gymclass = GymClass.view(params[:id].to_i)
  erb(:"gymclass/show")
end

post '/classes/create' do
  gymclass = GymClass.new(params)
  gymclass.save()
  redirect to("/classes/#{gymclass.id}")
end

post '/classes/:id/delete' do
  gymclass = GymClass.view(params[:id].to_i)
  gymclass.delete()
  redirect to('/classes/all')
end

post '/classes/:id' do
  gymclass = GymClass.new(params)
  gymclass.update()
  redirect to("/classes/#{gymclass.id}")
end

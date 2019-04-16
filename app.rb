require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/booking_controller.rb')
require_relative('controllers/gymclass_controller.rb')
require_relative('controllers/member_controller.rb')
also_reload('models/*')


get '/' do
  erb(:index)
end

get '/sitemap' do
  erb(:show)
end

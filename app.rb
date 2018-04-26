require 'sinatra'
require 'sinatra/activerecord'
require 'rake'
require 'pg'

set :database, {adapter: 'postgresql', database: 'rumblr'}

get '/' do
  erb :index
end

get '/signin' do
  erb :signin, :layout => false
end

get '/signup' do
  erb :signup, :layout => false
end

get '/:user' do

end

get '/:user/posts' do

end

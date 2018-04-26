require 'sinatra'
require 'sinatra/activerecord'
require 'rake'
require 'pg'
require_relative './models/User.rb'
require_relative './models/Post.rb'
require_relative './models/Tag.rb'
require_relative './models/Post_Tag.rb'
require_relative './models/Comment.rb'

set :database, {adapter: 'postgresql', database: 'rumblr'}

configure do
  enable :sessions unless test?
  set :session_secret, "secret"
end

get '/' do
  erb :index
end

get '/newpost' do
  erb :newpost
end

get '/user/signin' do
  erb :signin, :layout => false
end

post '/user/signin' do 
  @user = User.find_by(email: params[:email], password: params[:password])
  if @user != nil
    session[:id] = @user.id
    erb :profile
  else   
  # Could not find this user. Redirecting them to the signup page
    redirect '/signup'
  end 
end

get '/signup' do
  erb :signup, :layout => false
end

get '/:user' do

end

get '/:user/posts' do

end

get '/logout' do
  session.clear
  redirect '/signin'
end

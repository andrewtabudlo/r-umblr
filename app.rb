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
  if session[:id] != nil
    @user = User.find_by(id: session[:id])
  end
  @posts = Post.where(created_at: (Time.now.midnight - 1.day)..Time.now).order(created_at: :desc).limit(20)
  erb :index
end

get '/user/signin' do
  erb :signin, :layout => false
end

post '/user/signin' do 
  @user = User.find_by(email: params[:email], password: params[:password])
  if @user != nil
    session[:id] = @user.id
    redirect '/' + @user.username
  else   
  # Could not find this user. Redirecting them to the signup page
    redirect '/signup'
  end 
end

get '/signup' do
  erb :signup, :layout => false
end

post '/signup' do
  @user = User.create(fname: params[:fname], lname: params[:lname], username: params[:username], email: params[:email], password: params[:password])
  session[:id] = @user.id
  redirect '/' + @user.username
end

get '/signout' do
  session.clear
  redirect '/'
end

get '/newpost' do
  @user = User.find(session[:id])
  erb :newpost
end

post '/newpost' do
  @user = User.find(session[:id])
  @newpost = Post.create(title: params[:title], body: params[:body], user_id: @user.id)
  redirect '/' + @user.username
end

get '/delete/:post_id' do
  @user = User.find(session[:id])
  Post.destroy(params[:post_id])
  redirect '/' + @user.username
end

get '/:user' do
  @user = User.find(session[:id])
  @posts = Post.where(user_id: @user.id).order(created_at: :desc).limit(20)
  erb :profile
end

get '/:user/profile' do
  @user = User.find(session[:id])
  erb :user
end

get '/:user/posts' do
  @user = User.find(session[:id])
  erb :profile
end

get '/:user/delete' do
  Post.where(user_id: session[:id]).destroy_all
  User.where(username: params[:user]).destroy_all
  session.clear
  redirect '/'
end

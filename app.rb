require 'sinatra'
require 'sinatra/activerecord'
require 'rake'
require 'pg'
require 'sendgrid-ruby'
require_relative './models/User.rb'
require_relative './models/Post.rb'
require_relative './models/Tag.rb'
require_relative './models/Post_Tag.rb'
require_relative './models/Comment.rb'
include SendGrid

# set :database, {adapter: 'postgresql', database: 'rumblr'}

configure do
  enable :sessions unless test?
  set :session_secret, "secret"
end

get '/' do
  if session[:id] != nil
    @user = User.find_by(id: session[:id])
  end
  @posts = Post.all().order(created_at: :desc).limit(20)
  @feature1 = Post.find_by(id: 1)
  @feature2 = Post.find_by(id: 2)
  @feature3 = Post.find_by(id: 3)
  erb :index
end

post '/' do
  if session[:id] != nil
    @user = User.find_by(id: session[:id])
  end
  @posts = Post.all().order(created_at: :desc).limit(20).offset(20)
  erb :index
end

post '/subscribe' do
  template = (erb :htmlemail, :layout => false)
  from = Email.new(email: 'info@rumblr.com')
  to = Email.new(email: params[:email])
  subject = 'Thank you for subscribing!'
  content = Content.new(type: 'text/html', value: template)
  mail = Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  # puts response.parsed_body
  puts response.headers
redirect '/'
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

get '/:user/editpost/:post_id' do
  @user = User.find(session[:id])
  @post = Post.find_by(id: params[:post_id])
  erb :editpost
end

post '/:user/editpost/:post_id' do
  @user = User.find(session[:id])
  Post.find_by(id: params[:post_id]).update(title: params[:title], body: params[:body])
  redirect '/' + @user.username
end

get '/delete/:post_id' do
  @user = User.find(session[:id])
  Post.destroy(params[:post_id])
  redirect '/' + @user.username
end

get '/:user' do
  if session[:id] != nil
    @user = User.find_by(id: session[:id])
  end
  @userx = User.find_by(username: params[:user])
  @posts = Post.where(user_id: @userx.id).order(created_at: :desc).limit(20)
  erb :profile
end

get '/:user/posts' do
  if session[:id] != nil
    @user = User.find_by(id: session[:id])
  end
  erb :profile
end

get '/:user/posts/:post_id' do
  if session[:id] != nil
    @user = User.find_by(id: session[:id])
  end
  @post = Post.find_by(id: params[:post_id])
  erb :post
end

get '/:user/delete' do
  Post.where(user_id: session[:id]).destroy_all
  User.where(username: params[:user]).destroy_all
  session.clear
  redirect '/'
end

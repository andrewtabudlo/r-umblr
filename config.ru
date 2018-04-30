require './app' #or whatever your main app file is called 
require_relative './models/User.rb'
require_relative './models/Post.rb'
require_relative './models/Tag.rb'
require_relative './models/Post_Tag.rb'
require_relative './models/Comment.rb'

run Sinatra::Application

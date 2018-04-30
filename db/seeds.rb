users = [
  {fname: 'Jon', lname: 'Doe', username: 'jdoe', email: 'jondoe@example.com', password: '123123'},
  {fname: 'Anne', lname: 'Doe', username: 'adoe', email: 'annedoe@example.com', password: '123123'}
]

posts = [
  {title: 'first post', body: 'this is the first post', user_id: 1},
  {title: 'second post', body: 'this is the second post', user_id: 2},
  {title: 'third post', body: 'this is the third post', user_id: 1},
]

users.each do |u|
  User.create(u)
end

posts.each do |p|
  Post.create(u)
end

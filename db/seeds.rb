users = [
  {fname: 'Jon', lname: 'Doe', username: 'jdoe', email: 'jondoe@example.com', password: '123123'},
  {fname: 'Anne', lname: 'Doe', username: 'adoe', email: 'annedoe@example.com', password: '123123'}
]

users.each do |u|
    User.create(u)
end

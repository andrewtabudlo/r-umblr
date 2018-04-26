users = [
  {first_name: 'Jon', last_name: 'Doe', email: 'e@example.com'},
  {first_name: 'Jane', last_name: 'Doe', email: 'e@example.com'}
]

users.each do |u|
    User.create(u)
end

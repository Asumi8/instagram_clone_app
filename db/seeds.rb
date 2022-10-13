50.times do |n|
  name = Faker::Internet.username
  email = Faker::Internet.email
  password = Faker::Internet.password
  User.create!(name: name, 
              email: email, 
              password: password,
              
              )
end


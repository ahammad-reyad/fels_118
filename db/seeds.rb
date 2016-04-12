User.create!(name: "Example User",
  email: "admin@example.com",
  password: "admin1",
  password_confirmation: "admin1",
  is_admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.org"
  password = "password"
  User.create!(name:  name,
    email: email,
    password: password,
    password_confirmation: password)
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow followed}
followers.each {|follower| follower.follow user}

2.times do |n|
  category_name  = "Category-#{n+1}"
  Category.create!(category_name: category_name)
end

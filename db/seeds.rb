Package.create!(name:  "Example Package",
             link: "example-0@sp.org",
             package_info: "exampleexampleexampleexampleexampleexampleexampleexampleexampleexample-0"
             )

99.times do |n|
  name  = Faker::Name.name
  link = "example-#{n+1}@rtut.org"
  package_info  = "exampleexampleexampleexampleexampleexampleexampleexampleexampleexample-#{n+1}"
  Package.create!(name:  name,
               link: link,
               package_info: package_info)
end

User.create!(name:  "Example User",
             email: "example@sp.org",
             username: "example-0",
             password:              "foobar123",
             password_confirmation: "foobar123",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@rtut.org"
  username  = "example-#{n+1}"
  password = "password"
  User.create!(name:  name,
               email: email,
               username: username,
               password:              password,
               password_confirmation: password)
end

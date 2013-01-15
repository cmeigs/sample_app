namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    # create an admin user
    chad = User.create(name: "Chad Meigs",
                email: "cmeigs@gmail.com",
                password: "password",
                password_confirmation: "password")
    chad.toggle!(:admin)

    # create an admin user
    admin = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)

    # create 99 other users
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
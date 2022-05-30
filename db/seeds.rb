# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Destroy products..."
Product.destroy_all
puts "Destroy follow ups..."
FollowUp.destroy_all
puts "Destroy users.."
User.destroy_all

10.times do
  user = User.new(username: Faker::Internet.username,first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "azerty", city: "Paris")
  user.save!
end

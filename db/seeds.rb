# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# puts "Destroy products..."
# Product.destroy_all
# puts "Destroy follow ups..."
# FollowUp.destroy_all
# puts "Destroy users.."
# User.destroy_all

puts "Creating Users..."
10.times do
  user = User.new(username: Faker::Internet.username,first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "azerty", city: "Paris")
  user.save!
end
puts "Finish Users"

puts "Creating Products..."
10.times do
  if rand(0..1)
    name = Faker::Food.vegetables
    category = "vegetables"
  else
    name = Faker::Food.fruits
    category = "fruits"
  end
  product = Product.new(name: name, category: category, sub_category: Faker::Food.ethnic_category, description: Faker::Food.description, start_month: rand(0...12), end_month: rand(12..24), localable: rand(0..1).zero?)
  product.save!
end
puts "Finish Products"

puts "Creating Follow ups...."

Product.all.each do |product|
  fu = FollowUp.new(user: User.find(rand(1..10)), product: product, month_number: rand(0..24), carbon_calcul: rand(0..100) , local: rand(0..1).zero?, bio: rand(0..1).zero?)
  fu.save!
end
puts "Finish Follow ups"

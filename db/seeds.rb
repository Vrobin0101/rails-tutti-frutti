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
# User.destroy_allZ

puts "Creating Perso Users..."
user = User.create(username: "Marlou", first_name: "Marly", last_name: "Diallo", email: "marly@gmail.com", password: "azerty")
user = User.create(username: "Max", first_name: "Maxime", last_name: "Andre", email: "maxime@gmail.com", password: "azerty")
user = User.create(username: "Thib", first_name: "Thibault", last_name: "Chassine", email: "thibault@gmail.com", password: "azerty")
user = User.create(username: "Robinou", first_name: "Robin", last_name: "Varetz", email: "robin@gmail.com", password: "azerty")
puts "Finish Perso Users"

puts "Creating Random Users..."
6.times do
  user = User.new(username: Faker::Internet.username,first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "azerty")
  user.save!
end
puts "Finish Random Users"

puts "Creating Products..."

file = YAML.load_file('db/seed.yml')
file.each do |hash|
  name = hash.keys.first
  image = URI.open("https://res.cloudinary.com/de6cwutjk/image/upload/tutti%20frutti/#{hash[name]['image_id']}.jpg")
  product = Product.new(name: hash.keys.first, category: hash[name]['category'], sub_category: hash[name]['sub_category'], description: hash[name]['description'], localable: hash[name]['localable'], start_month: hash[name]['start_month'], end_month: hash[name]['end_month'])
  product.photo.attach(io: image, filename: hash[name], content_type: 'jpg')
  product.save!
end
puts "Finish Products"

puts "Creating Follow ups...."

Product.all.each do |product|
  fu = FollowUp.new(user: User.find(rand(1..10)), product: product, month_number: rand(0..24), carbon_calcul: rand(0..100) , local: rand(0..1).zero?, bio: rand(0..1).zero?)
  fu.save!
end
puts "Finish Follow ups"

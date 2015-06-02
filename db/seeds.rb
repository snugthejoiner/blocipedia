# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

# Create Users
5.times do
  user = User.new(
    username: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
    )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create Wikis
50.times do
  Wiki.create!(
    user:   users.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
    )
end
wikis = Wiki.all

user = User.first
user.skip_reconfirmation!
user.update_attributes!(
  email: 'jedpmail@gmail.com',
  password: 'qwertyuiop'
  )

puts "Seed finished"
puts "#{users.count} users created"
puts "#{wikis.count} wikis created"
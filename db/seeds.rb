# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Platforms table
platforms = ["Nintendo", "Playstation", "Xbox", "Sega", "Other"]

if Platform.count == 0
  platforms.each do |platform|
    Platform.create(name: platform)
    puts "Created #{platform} platform"
  end
end

# Categories table
categories = ["Cartridge/disc", "Console", "Accessories", "Miscellaneous"]

if Category.count == 0
  categories.each do |category|
    Category.create(name: category)
    puts "Created #{category} category"
  end
end

# Conditions table
conditions = ["Poor", "Acceptable", "Good", "Great", "Mint"]

if Condition.count == 0
  conditions.each do |condition|
    Condition.create(name: condition)
    puts "Created #{condition} condition"
  end
end

# Test user
if User.count == 0
  User.create(username: "admin", email: "admin@testing.com", password: "admins", password_confirmation: "admins", admin: true)
  puts "Created admin user"
end
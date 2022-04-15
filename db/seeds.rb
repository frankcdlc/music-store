# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
# Create 10 artists.

10.times do |n|
    birth_date = Faker::Date.between(from: 120.year.ago, to:18.year.ago)
    artist = Artist.new(
      name: Faker::Name.first_name, 
      nationality: Faker::Nation.nationality, 
      birth_date: birth_date,
      death_date: Faker::Date.between(from: birth_date, to: Date.today),
      biography: Faker::Lorem.sentence(word_count: n * 2)
    )
    if artist.save
        puts "Artist#{n+1} created successfully"
    else
        puts "Artist#{n+1} #{artist.errors.full_messages.join(", ")}"
    end
end
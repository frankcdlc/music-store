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

# ALBUM Create between 2 to 6 albums for each artist. -> deberia estar adentro de la anterior iteracion?
40.times do |n| 
  album = Album.new(
    name: Faker::Music.album,
    price: Faker::Number.number(digits: 2), # deberia ser con decimnales??????
    # duratioen: 
    artist_id: Artist.find((n/4)+1).id
  )
  if album.save
    puts "Album#{n+1} created successfully"
  else
    puts "Album#{n+1} #{album.errors.full_messages.join(", ")}"
  end
end

# TALVEZ GRATEFULDEADD PUEDE SER OTRO NOMBRE???????????? 

# SONG # Create between 4 and 10 songs for each album, necesitro la instancia de cada album

160.times do |n|
  song = Song.new(
    name: Faker::Music::GratefulDead.song,
    duration: Faker::Number.between(from: 120, to: 300), # en segundos 
    album_id: Album.find((n/4)+1).id
  )
  if song.save
    puts "Song#{n+1} created successfully"
  else
    puts "Song#{n+1} #{song.errors.full_messages.join(", ")}"
  end
end



# #  COSTUMER # Create 15 customers.
15.times do |n|
  costumer = Customer.new(
    name: Faker::Name.first_name, 
    email: Faker::Internet.free_email, # yahoo hotmail gmail
    # email: Faker::Internet.email(domain: 'hotmail.com') #=> "alice@example.name"
    password: Faker::Alphanumeric.alphanumeric(number: 10),
    active_flag: false # ???????????????????????? ACTIVE FLAG DEFAULT FALSE????
  )
  if costumer.save
    puts "Costumer#{n+1} created successfully"
  else
    puts "Costumer#{n+1} #{costumer.errors.full_messages.join(", ")}"
  end
end


# # ORDER # Create between 1 and 5 orders for each customer. 
20.times do |n|
  order = Order.new(
    date: Faker::Date.between(from: 120.year.ago, to: Date.today), # TRHIS CAN BE INPROVED
    total: Faker::Number.decimal(l_digits: 2), #=> 11.88 esto debe ser un decimal-> puede denpender de albumn order y album price but idk how
    customer_id: Customer.all.find(((n/2)+1)).id
  )
  if order.save
    puts "Order#{n+1} created successfully"
  else
    puts "Order#{n+1} #{order.errors.full_messages.join(", ")}"
  end
end





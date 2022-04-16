# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
Create 10 artists.
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
artists = Artist.all # creado para guardar las instancais

artists.each do |artist|
  4.times do |n|
    album=artist.albums.new(
      name: Faker::Music.album,
      price: Faker::Number.decimal(l_digits: 2)# deberia ser con decimnales??????
    )
    if album.save
      puts "Album#{n+1} created successfully"
    else
      puts "Album#{n+1} #{album.errors.full_messages.join(", ")}"
    end
  end
end


# SONG # Create between 4 and 10 songs for each album, necesitro la instancia de cada album
albums = Album.all

albums.each do |album|
  rand(4..10).times.each do |n|
    song = album.songs.new(
      name: Faker::Music::GratefulDead.song,
      duration: Faker::Number.between(from: 120, to: 300), # en segundos 
    )
    if song.save
      puts "Song#{n+1} created successfully"
    else
      puts "Song#{n+1} #{song.errors.full_messages.join(", ")}"
    end
  end
end

# Agregar duracion a un album

albums.each do |album|
  songs = Song.where(album_id:album.id)
  duration = 0
  songs.each { |song| duration += song.duration }
  album.duration = duration
  if album.save
    puts "Album#{album.id} update successfully"
  else
    puts "Album#{album.id} #{album.errors.full_messages.join(", ")}"
  end
end


# #  COSTUMER # Create 15 customers.
15.times do |n|
  costumer = Customer.new(
    name: Faker::Name.first_name, 
    email: Faker::Internet.free_email, # yahoo hotmail gmail
    # email: Faker::Internet.email(domain: 'hotmail.com') #=> "alice@example.name"
    password: Faker::Alphanumeric.alphanumeric(number: 10),
    active_flag: true # ???????????????????????? ACTIVE FLAG DEFAULT FALSE????
  )
  if costumer.save
    puts "Costumer#{n+1} created successfully"
  else
    puts "Costumer#{n+1} #{costumer.errors.full_messages.join(", ")}"
  end
end


# # ORDER # Create between 1 and 5 orders for each customer. 
customers = Customer.all

customers.each do |customer|
  rand(1..5).times.each do |n|
    order = customer.orders.new(
      date: Faker::Date.between(from: 120.year.ago, to: Date.today), # TRHIS CAN BE INPROVED
      total: 0.1
    )
    if order.save
      puts "Order#{n+1} created successfully"
      rand(1..3).times.each do |i|
        order.album_order.create(
          album_id: Album.all.sample.id
        )
      end
    else
      puts "Order#{n+1} #{order.errors.full_messages.join(", ")}"
    end
  end
  
end


# Cambiar total
orders = Order.all

orders.each do |order|
  total = 0
  album_orders=AlbumOrder.where(order_id:order.id)
  album_orders.each do |album_order|
    album = Album.find(id = album_order.album_id)
    total += album.price
  end

  order.total = total
  if order.save
    puts "Order#{order.id} update successfully"
  else
    puts "Order#{order.id} #{order.errors.full_messages.join(", ")}"
  end
end




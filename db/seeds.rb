# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "faker"
# Create 10 artists.
10.times do |n|
  birth_date = Faker::Date.between(from: 120.years.ago, to: 18.years.ago)
  artist = Artist.new(
    name: Faker::Name.first_name,
    nationality: Faker::Nation.nationality,
    birth_date:,
    death_date: Faker::Date.between(from: birth_date, to: Time.zone.today),
    biography: Faker::Lorem.sentence(word_count: n * 2)
  )
  if artist.save
    Rails.logger.debug { "Artist#{n + 1} created successfully" }
  else
    Rails.logger.debug { "Artist#{n + 1} #{artist.errors.full_messages.join(', ')}" }
  end
end

# ALBUM Create between 2 to 6 albums for each artist. -> deberia estar adentro de la anterior iteracion?
artists = Artist.all # creado para guardar las instancais

artists.each do |artist|
  4.times do |n|
    album = artist.albums.new(
      name: Faker::Music.album,
      price: Faker::Number.decimal(l_digits: 2) # deberia ser con decimnales??????
    )
    if album.save
      Rails.logger.debug { "Album#{n + 1} created successfully" }
    else
      Rails.logger.debug { "Album#{n + 1} #{album.errors.full_messages.join(', ')}" }
    end
  end
end

# SONG # Create between 4 and 10 songs for each album, necesitro la instancia de cada album
albums = Album.all

albums.each do |album|
  duration = 0
  rand(4..10).times.each do |n|
    song = album.songs.new(
      name: Faker::Music::GratefulDead.song,
      duration: Faker::Number.between(from: 120, to: 300) # en segundos
    )
    duration += song.duration

    if song.save
      Rails.logger.debug { "Song#{n + 1} created successfully" }
    else
      Rails.logger.debug { "Song#{n + 1} #{song.errors.full_messages.join(', ')}" }
    end
  end

  # Agregar duracion a un album
  album.duration = duration
  if album.save
    Rails.logger.debug { "Album#{album.id} update successfully" }
  else
    Rails.logger.debug { "Album#{album.id} #{album.errors.full_messages.join(', ')}" }
  end
end

# albums.each do |album_update|
#   songs = Song.where(album_id: album_update.id)
#   duration = 0
#   songs.each { |song| duration += song.duration }
#   album_update.duration = duration
#   if album_update.save
#     Rails.logger.debug { "Album#{album_update.id} update successfully" }
#   else
#     Rails.logger.debug { "Album#{album_update.id} #{album_update.errors.full_messages.join(', ')}" }
#   end
# end

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
    Rails.logger.debug { "Costumer#{n + 1} created successfully" }
  else
    Rails.logger.debug { "Costumer#{n + 1} #{costumer.errors.full_messages.join(', ')}" }
  end
end

# # ORDER # Create between 1 and 5 orders for each customer.
customers = Customer.all

customers.each do |customer|
  rand(1..5).times.each do |n|
    order = customer.orders.new(
      date: Faker::Date.between(from: 120.years.ago, to: Time.zone.today), # TRHIS CAN BE INPROVED
      total: 0.1
    )
    if order.save
      Rails.logger.debug { "Order#{n + 1} created successfully" }
      rand(1..3).times.each do |_i|
        order.album_order.create(
          album_id: Album.all.sample.id
        )
      end
    else
      Rails.logger.debug { "Order#{n + 1} #{order.errors.full_messages.join(', ')}" }
    end
  end
end

# Cambiar total
orders = Order.all

orders.each do |order|
  total = 0
  album_orders = AlbumOrder.where(order_id: order.id)
  album_orders.each do |album_order|
    album = Album.find(_id = album_order.album_id)
    total += album.price
  end

  order.total = total
  if order.save
    Rails.logger.debug { "Order#{order.id} update successfully" }
  else
    Rails.logger.debug { "Order#{order.id} #{order.errors.full_messages.join(', ')}" }
  end
end

class AddRelationships < ActiveRecord::Migration[7.0]
  def change
    add_reference(:albums, :artists, foreign_key: true)
    add_reference(:songs, :albums, foreign_key: true)
    add_reference(:album_orders, :albums, foreign_key: true)
    add_reference(:album_orders, :orders, foreign_key: true)
    add_reference(:orders, :customers, foreign_key: true)
  end
end

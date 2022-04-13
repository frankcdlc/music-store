class AddRelationships < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key(:albums, :artists)
    add_foreign_key(:songs, :albums)
    add_foreign_key(:album_orders, :albums)
    add_foreign_key(:album_orders, :orders)
    add_foreign_key(:orders, :customers)
  end
end

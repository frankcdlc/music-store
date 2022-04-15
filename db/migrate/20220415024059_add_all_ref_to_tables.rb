class AddAllRefToTables < ActiveRecord::Migration[7.0]
  def change
    # Add FK: artist_id to Album
    add_reference :albums, :artist, null: false, foreign_key: true
    # Add FK: album_id to Song
    add_reference :songs, :album, null: false, foreign_key: true
    # Add FK: customer_id to Order
    add_reference :orders, :customer, null: false, foreign_key: true
    # Add FK's: album_id, order_id to Album_Order
    add_reference :album_orders, :album, null: false, foreign_key: true
    add_reference :album_orders, :order, null: false, foreign_key: true
  end
end
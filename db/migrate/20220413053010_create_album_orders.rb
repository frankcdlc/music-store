class CreateAlbumOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :album_orders do |t|

      t.timestamps
    end
  end
end

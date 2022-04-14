class ChangeDataTypeOfBiographyToArtists < ActiveRecord::Migration[7.0]
  def change
    change_column :artists, :biography, :text
  end
end

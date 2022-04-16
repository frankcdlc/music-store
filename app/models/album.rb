class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs
  has_many :album_order
  validates :artist, presence: true
  validates :name, presence: true
  validates :price, comparison: { greater_than: 0 }
end

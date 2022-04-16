class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs, dependent: :delete_all
  has_many :album_order, dependent: :nullify
  validates :name, presence: true
  validates :price, comparison: { greater_than: 0 }
end

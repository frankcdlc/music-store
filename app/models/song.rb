class Song < ApplicationRecord
  belongs_to :album
  validates :name, presence: true
  validates :duration, comparison: { greater_than: 0 }
end

class AlbumOrder < ApplicationRecord
  belongs_to :album
  belongs_to :order
end

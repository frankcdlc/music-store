class Customer < ApplicationRecord
  has_many :orders
  validates :name presence: true, uniqueness: true, on: :create
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, presence: true, length: {minimum: 6}, format: { with: /.*[0-9].*/, on: :create}
end

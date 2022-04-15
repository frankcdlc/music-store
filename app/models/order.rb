class Order < ApplicationRecord
  belongs_to :customer
  has_many :albums
  validates :total, comparison: { greater_than: 0 }
  validate :date_buy

  def date_buy
    if birth_date.present? &&  date > Date.today
      errors.add(:date, message: 'the date cannot be in the future')
    end
  end

end

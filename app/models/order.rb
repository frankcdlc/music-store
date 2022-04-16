class Order < ApplicationRecord
  belongs_to :customer
  has_many :album_order, dependent: :nullify
  validates :total, comparison: { greater_than: 0 }
  validate :date_buy

  def date_buy
    return unless date.present? && date > Time.zone.today

    errors.add(:date, message: "the date cannot be in the future")
  end
end

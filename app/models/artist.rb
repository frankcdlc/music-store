class Artist < ApplicationRecord
  has_many :albums
  validates :name, presence: true
  validate :validate_age
  validate :death

  def validate_age
    if birth_date.present? &&  birth_date > Date.today
      errors.add(:birth_date, 'birth date cannot be in the future')
    end
  end

  def death
    if death_date.present?
      if birth_date.blank?
        errors.add(:death_date, 'birth date do not exist')
      elsif birth_date > death_date
        errors.add(:death_date, 'death date is after the birth date')
      end
    end
  end
end

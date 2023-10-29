class Actor < ApplicationRecord
  validates :name, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }
  validates :height, numericality: { greater_than: 0 }
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
end

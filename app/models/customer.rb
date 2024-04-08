class Customer < ApplicationRecord
  has_many :orders

  enum sex: [:male, :female]
end

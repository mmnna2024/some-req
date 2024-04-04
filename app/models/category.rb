class Category < ApplicationRecord
  has_many :items

  validates :name, :price, presence: true
end

class Item < ApplicationRecord
  belongs_to :order
  belongs_to :category
  has_one_attached :image

  validates :price, presence: true
end

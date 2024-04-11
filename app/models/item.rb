class Item < ApplicationRecord
  belongs_to :order
  belongs_to :category
  has_many_attached :images

  validates :price, presence: true
end

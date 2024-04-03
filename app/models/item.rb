class Item < ApplicationRecord
  belongs_to :order
  belongs_to :category
  has_one_attached :image
end

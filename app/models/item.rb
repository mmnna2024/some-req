class Item < ApplicationRecord
  belongs_to :order
  belongs_to :category
  has_many_attached :image
end

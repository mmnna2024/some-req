class Item < ApplicationRecord
  belongs_to :order
  belongs_to :category
<<<<<<< HEAD
  has_many_attached :image
=======
  has_one_attached :image

  validates :price, presence: true
>>>>>>> main
end

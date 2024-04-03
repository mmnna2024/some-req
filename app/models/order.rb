class Order < ApplicationRecord
  has_many :items
  belongs_to :customer
  belongs_to :shipping
end

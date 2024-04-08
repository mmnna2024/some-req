class Order < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :customer
  belongs_to :shipping, optional: true

  enum status: [:unchecked_order, :checked_order]
  enum channel: [:online, :shop, :phonecall]

  def self.sort_with_ordered_on
    order(ordered_on: :asc)
  end

  def items_price_update
    items.each do |item|
      item.update(price: item.category.price)
    end
  end

  def self.order_price_save
    total_price = 0
    self.items.each do |item|
      total_price += item.price
    end
    self.price = total_price
    self.save
  end
end

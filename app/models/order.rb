class Order < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :customer
  belongs_to :shipping, optional: true
  accepts_nested_attributes_for :items

  enum status: [:unchecked_order, :checked_order]
  enum channel: [:online, :shop, :phonecall]

  scope :sort_latest, -> {order(ordered_on: :desc)}
  scope :sort_oldest, -> {order(ordered_on: :asc)}

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

  def self.ransackable_attributes(auth_object = nil)
    ["channel", "created_at", "customer_id", "id", "note", "ordered_on", "price", "shipping_id", "status", "updated_at"]
  end
end

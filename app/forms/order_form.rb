class OrderForm
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment
  attr_accessor :category_ids, :customer_name, :customer_phonenumber, :customer_address, :order_note, :shipping_id

  def save
    ActiveRecord::Base.transaction do
      customer = Customer.create!(name: customer_name, phonenumber: customer_phonenumber, address: customer_address)
      order = Order.create!(note: order_note, customer_id: customer.id, shipping_id: shipping_id, ordered_on: Time.current, status: 0)

      category_ids.each do |category_id|
        category = Category.find_by_id(category_id)
        if category
          item = Item.create!(order_id: order.id, category_id: category.id, price: category.price)
        end
      end
    end
  end
end
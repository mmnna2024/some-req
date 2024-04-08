class OrderForm
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment
  attr_accessor :category_ids, :customer_name, :customer_email, :customer_phonenumber, 
                :customer_address, :customer_age, :customer_sex, :shipping_id, :order_note, :status, :channel

  def save
    ActiveRecord::Base.transaction do
      customer = Customer.create!(name: customer_name, email: customer_email, phonenumber: customer_phonenumber, address: customer_address, age: customer_age, sex: customer_sex)
      order = Order.create!(note: order_note, customer_id: customer.id, shipping_id: shipping_id, ordered_on: Time.current, status: status, channel: channel)

      category_ids.each do |category_id|
        category = Category.find_by_id(category_id)
        if category
          item = Item.create!(order_id: order.id, category_id: category.id, price: category.price)
        end
      end
    end
  end
end
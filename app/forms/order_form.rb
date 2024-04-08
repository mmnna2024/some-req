class OrderForm
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment
  attr_accessor :category_ids, :customer_name, :customer_email, :customer_phonenumber, 
                :customer_address, :customer_age, :customer_sex, :shipping_id, :order_note, :status, :channel, :ordered_on

  def initialize(attributes = nil, order: Order.new)
    @order = order
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    ActiveRecord::Base.transaction do
      if @order.customer
        @order.customer.update!(name: customer_name, phonenumber: customer_phonenumber, address: customer_address)
      else
        customer = Customer.create!(name: customer_name, email: customer_email, phonenumber: customer_phonenumber, address: customer_address, age: customer_age, sex: customer_sex)
        @order.customer = customer
      end

      if @order.persisted?
        @order.update!(note: order_note, shipping_id: shipping_id, ordered_on: ordered_on, status: status, channel: channel)
      else
        @order = Order.create!(note: order_note, customer_id: customer.id, shipping_id: shipping_id, ordered_on: Time.current, status: status, channel: channel)
      end

      @order.items.destroy_all
      category_ids.each do |category_id|
        category = Category.find_by_id(category_id)
        if category
          item = Item.create!(order_id: order.id, category_id: category.id, price: category.price)
        end
      end
    end
  end

  def to_model
    @order
  end

  private

  attr_reader :order

  def default_attributes
    {
      customer_name: @order.customer&.name,
      customer_phonenumber: @order.customer&.phonenumber,
      customer_address: @order.customer&.address,
      shipping_id: @order.shipping_id,
      order_note: @order.note,
      status: @order.status,
      channel: @order.channel,
      category_ids: @order.items.pluck(:category_id),
    }
  end
end

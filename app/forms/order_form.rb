class OrderForm
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment
  attr_accessor :id, :category_ids, :name, :email, :phonenumber, :address, :age, :sex,
                :shipping_id, :note, :status, :channel, :ordered_on, :items, :url

  with_options presence: true do
    validates :category_ids
    validates :name, length: { maximum: 20 }
    validates :phonenumber
    validates :email
    validates :address
  end

  def valid?
    if @items
      default_valid = super
      # valid_items = @items.map { |v| v.valid? }.all?
      valid_items = @items.map do |v|
        result = v.valid?
        if !result
          errors.add(:items, v.errors.full_messages.join(", "))
        end
        result
      end.all?
      default_valid && valid_items
    else
      super
    end
  end

  def initialize(attributes = nil, order: Order.new)
    @order = order
    attributes ||= default_attributes
    super(attributes)
  end

  def items_attributes=(attributes) #
    @items = attributes.map do |i, attribute|
      order_item = @order.items.find_by(id: attribute[:id])
      if order_item
        order_item.price = attribute[:price]
      end
      order_item
    end
  end

  def set_url(url)
    @url = url
  end

  def save
    return if !valid?
    ActiveRecord::Base.transaction do
      if @order.customer
        @order.customer.update!(name: name, phonenumber: phonenumber, email: email, address: address, age: age, sex: sex)
      else
        customer = Customer.create!(name: name, phonenumber: phonenumber, email: email, address: address, age: age, sex: sex)
        @order.customer = customer
      end
      if @order.persisted?
        @order.update!(note: note, shipping_id: shipping_id, status: status, channel: channel)

        items_to_remove = []
        @order.items.each_with_index do |item, index|
          category_id = category_ids[index]
          if category_id.present?
            price = @items[index].price
            item.update!(order_id: order.id, category_id: category_id, price: price)
          else
            items_to_remove << item
          end
        end
        items_to_remove.each do |item|
          item.destroy
        end

        @order.update!(price: @order.items.sum(:price))
      else
        @order = Order.create!(note: note, customer_id: customer.id, shipping_id: shipping_id, ordered_on: Time.current, status: status, channel: channel)
        total_order_price = 0
        if category_ids.present?
          binding.irb
          category_ids.each do |category_id|
            category = Category.find_by_id(category_id)
            if category
              item = Item.create!(order_id: order.id, category_id: category.id, price: category.price, image: image)
              total_order_price += item.price
            end
          end
        end
        @order.update!(price: total_order_price)
      end
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def to_model
    @order
  end

  private

  attr_reader :order

  def default_attributes
    {
      name: @order.customer&.name,
      phonenumber: @order.customer&.phonenumber,
      email: @order.customer&.email,
      address: @order.customer&.address,
      age: @order.customer&.age,
      sex: @order.customer&.sex,
      shipping_id: @order.shipping_id,
      note: @order.note,
      status: @order.status,
      channel: @order.channel,
      category_ids: @order.items.pluck(:category_id),
      items: @order.items,
      id: @order.id,
    }
  end
end

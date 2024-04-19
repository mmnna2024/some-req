class OrderForm
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment
  attr_accessor :id, :category_ids, :name, :email, :phonenumber, :address, :age, :sex,
                :shipping_id, :note, :status, :channel, :ordered_on, :items, :url, :order_items
  with_options presence: true do
    validates :category_ids
    validates :name, length: { maximum: 20 }
    validates :phonenumber
    validates :address
    validates :shipping_id
  end
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, format: { with: VALID_EMAIL_REGEX }

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

  def valid?
    if @items
      default_valid = super
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

  def set_url(url)
    @url = url
  end

  def save
    return unless valid?
    ActiveRecord::Base.transaction do
      customer_data = {
        name: name,
        phonenumber: phonenumber,
        email: email,
        address: address,
        age: age,
        sex: sex
      }
      if @order.persisted?
        # 既存の注文を更新する
        # service objectを使って、注文のフローを更新する
        # ex) service = OrderFlowService.new(@order)
        update_order_flow(@order, customer_data)
      else
        create_order_flow(@order, customer_data)
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error(e.message)
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
      id: @order.id
    }
  end

  def update_order_flow(order, customer_data)
    order.customer.update!(customer_data)
    order.update!(
      note: note,
      shipping_id: shipping_id,
      status: status,
      channel: channel
    )

    items_to_remove = []
    order.items.each_with_index do |item, index|
      category_id = category_ids[index]
      if category_id.present?
        price = items[index].price
        item.update!(order_id: order.id, category_id: category_id, price: price)
      else
        items_to_remove << item
      end
    end
    items_to_remove.map(&:destroy)

    order.update!(price: order.items.sum(:price))
  end

  def create_order_flow(order, customer_data)
    customer = Customer.create!(customer_data)
    order = Order.create!(
      note: note,
      customer_id: customer.id,
      shipping_id: shipping_id,
      ordered_on: Time.current,
      status: status,
      channel: channel
      )
    total_order_price = 0
    #オンライン注文の場合
    if order.channel == 'online'
      if order_items.present?
        order_items.values.each do |item|
          category = Category.find_by_id(item.fetch(:category_id))
          if category
            item = Item.create!(
              order_id: order.id,
              category_id: category.id,
              price: category.price,
              images: item.fetch(:images).values
              )
            total_order_price += item.price
          end
        end
      end
    else
    #ショップ、電話注文の場合
      if category_ids.present?
        category_ids.each do |category_id|
          category = Category.find_by_id(category_id)
          if category
            item = Item.create!(
              order_id: order.id,
              category_id: category.id,
              price: category.price
              )
            total_order_price += item.price
          end
        end
      end
    end
    order.update!(price: total_order_price)
  end
end

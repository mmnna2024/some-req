class OrderService
  def self.create_order(order_params)
    order = Order.new(order_params)
    if order.save
      OrderMailer.order_confirmation(order).deliver_now
      OrderMailer.order_notification(order).deliver_now
    end
    order
  end

  def self.update_order(order, order_params)
    order.update(order_params)
    order
  end

end

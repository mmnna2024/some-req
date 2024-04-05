class OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = Customer.new
    @categories = Category.where(display: true).map do |category|
      {
        id: category.id,
        name: category.name,
        price: category.price,
      }
    end
  end
end
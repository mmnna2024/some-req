class OrdersController < ApplicationController
  def new
    @categories = Category.where(display: true).map do |category|
      {
        id: category.id,
        name: category.name,
        price: category.price,
      }
    end
    @shippings = Shipping.all
  end

  def create
    @order = OrderForm.new(order_params)
    if @order.save
      render json: @order, status: :created
    else
      render json: { errors: 'error message' }, status: :unprocessable_entity
    end
  end
    
  def complete
    @items = Item.last
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to unchecked_index_orders_path
  end

  private

  def display_orders_items_price(orders)
    orders.each do |order|
      total_price = 0
      order.items.each do |item|
        total_price += item.category.price
      end
      order.price = total_price
    end
  end

  def order_params
    params.require(:order_form).permit(
      :ordered_on, :status, :channel, :price, :order_note, :customer_id, :shipping_id,
      { category_ids: [] }, :image, :customer_name, :customer_email, :customer_phonenumber, :customer_address, :customer_age, :customer_sex
    )
  end

end
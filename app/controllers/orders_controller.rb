class OrdersController < ApplicationController
  def new
    @categories = Category.where(display: true).map do |category|
      {
        id: category.id,
        name: category.name,
        price: category.price,
      }
    end
  end

  def create
    # @customer = Customer.new(customer_params)
    # @order = Order.new
    # # @order.customer = @customer(:id)
    # if @customer.save && @order.save
    #   redirect_to complete_orders_path, notice: t('.created')
    # else
    #   render :new
    # end
  end
    
  def complete
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

  def customer_prams
    params.require(:customer).permit(:name, :email, :phonenumber, :address, :sex, :age)
  end

  def order_prams
    params.require(:order).permit(:note)
  end

end
class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!, only: [:unchecked_index, :checked_index,:edit, :destroy]
  
  def unchecked_index
    @unchecked_orders = Order.includes(items: :category).where(status: 0).sort_with_ordered_on
    display_orders_items_price(@unchecked_orders)
  end

  def checked_index
    @checked_orders = Order.includes(items: :category).where(status: 1).sort_with_ordered_on
    display_orders_items_price(@checked_orders)
  end

  def new
    @order = OrderForm.new

    @categories = Category.where(display: true).map do |category|
      {
        id: category.id,
        name: category.name,
        price: category.price,
      }
    end
  end

  def create
    @order = OrderForm.new(order_params)
    if @order.save
      redirect_to unchecked_index_admin_orders_path
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to unchecked_index_admin_orders_path
  end

  private

  #現状受注に紐づいたカテゴリーが削除された場合エラー出る
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
      { category_ids: [] }, :customer_name, :customer_phonenumber, :customer_address
    )
  end
end

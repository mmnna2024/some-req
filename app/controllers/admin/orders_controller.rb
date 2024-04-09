class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!, only: [:unchecked_index, :checked_index, :edit, :destroy]

  def unchecked_index
    if params[:sort_update]
      @unchecked_orders = Order.includes(items: :category).where(status: 0).sort_latest
    end

    @unchecked_orders = Order.includes(items: :category).where(status: 0).sort_oldest.page(params[:page]).per(10)
  end

  def checked_index
    if params[:sort_update]
      @checked_orders = Order.includes(items: :category).where(status: 1).sort_oldest
    end

    @checked_orders = Order.includes(items: :category).where(status: 1).sort_latest.page(params[:page]).per(10)
  end

  def new
    order = Order.new
    @order_form = OrderForm.new(order: order)
    @order_form.set_url(admin_orders_path)
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.save
      redirect_to unchecked_index_admin_orders_path
    else
      render :new
    end
  end

  def edit
    order = Order.find(params[:id])
    @order_form = OrderForm.new(order: order)
    @order_form.set_url(admin_order_path(order))
  end

  def update
    order = Order.find(params[:id])
    @order_form = OrderForm.new(order_params, order: order)

    if @order_form.save
      redirect_to unchecked_index_admin_orders_path
    else
      render :edit
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to unchecked_index_admin_orders_path
  end

  private

  def order_params
    params.require(:order_form).permit(
      :customer_name, :customer_phonenumber, :customer_address, :customer_age, :customer_sex,
      :shipping_id,
      :order_note, :status, :channel, :ordered_on, items_attributes: [:id, :name, :price, :category_id],
                                                   category_ids: [],
    )
  end
end

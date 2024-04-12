class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!, only: [:unchecked_index, :checked_index, :new, :create, :edit, :update, :destroy]

  def unchecked_index
    if params[:sort_update]
      @unchecked_orders = Order.includes(items: :category).where(status: 0).sort_latest
    else
      @unchecked_orders = Order.includes(items: :category).where(status: 0).sort_oldest
    end

    @unchecked_orders = @unchecked_orders.page(params[:page]).per(10)
  end

  def checked_index
    if params[:sort_update]
      @checked_orders = Order.includes(items: :category).where(status: 1).sort_oldest
    else
      @checked_orders = Order.includes(items: :category).where(status: 1).sort_latest
    end

    @checked_orders = @checked_orders.page(params[:page]).per(10)
  end

  def new
    order = Order.new
    if flash[:form_data]
      @order_form = OrderForm.new(flash[:form_data], order: order)
    else
      @order_form = OrderForm.new(order: order)
    end
    @order_form.set_url(admin_orders_path)
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.save
      redirect_to unchecked_index_admin_orders_path
    else
      flash[:form_data] = params[:order_form]
      redirect_to new_admin_order_path, flash: { error: @order_form.errors.full_messages }
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
      @order_form.set_url(admin_order_path(order))
      redirect_to edit_admin_order_path, flash: { error: @order_form.errors.full_messages }
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
      :name, :phonenumber, :email, :address, :age, :sex,
      :shipping_id,
      :note, :status, :channel, :ordered_on, items_attributes: [:id, :name, :price, :category_id], category_ids: []
    )
  end
end

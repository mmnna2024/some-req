class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!, only: [:unchecked_index, :checked_index, :new, :create, :edit, :update, :destroy]

  def unchecked_index
    @q = Order.ransack(params[:q])
    @unchecked_orders = @q.result(distinct: true).includes(:customer, items: :category).where(status: 0).sort_oldest.page(params[:page]).per(10)
  end

  def checked_index
    @q = Order.ransack(params[:q])
    @checked_orders = @q.result(distinct: true).includes(items: :category).where(status: 1).sort_latest.page(params[:page]).per(10)
  end

  def new
    order = Order.new
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
      puts @order.errors.full_messages
      render json: { error: @order.errors.full_messages }, status: :unprocessable_entity
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
      if @order_form.status == "unchecked_order"
        redirect_to unchecked_index_admin_orders_path
      else
        redirect_to checked_index_admin_orders_path
      end
    else
      @order_form.set_url(admin_order_path(order))
      render :edit
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    if @order.status == "unchecked_order"
      redirect_to unchecked_index_admin_orders_path
    else
      redirect_to checked_index_admin_orders_path
    end
  end

  private

  def order_params
    params.require(:order_form).permit(
      :name, :phonenumber, :email, :address, :age, :sex,
      :shipping_id,
      :note, :status, :channel, :ordered_on, items_attributes: [:id, :name, :price, :category_id], category_ids: [],
    )
  end
end

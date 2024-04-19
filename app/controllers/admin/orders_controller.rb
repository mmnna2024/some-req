class Admin::OrdersController < AdminController

  def unchecked_index
  @q = Order.ransack(params[:q])
  @unchecked_orders = @q.result(distinct: true)
                      .includes(:customer, items: :category)
                      .unchecked_order
                      .sort_oldest
                      .page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def checked_index
    @q = Order.ransack(params[:q])
    @checked_orders = @q.result(distinct: true)
                      .includes(:customer, items: :category)
                      .checked_order
                      .sort_latest
                      .page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
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
      flash[:notice] = "仮受注一覧に登録しました"
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
        redirect_to unchecked_index_admin_orders_path, flash: { notice: "更新しました" }
      else
        redirect_to checked_index_admin_orders_path, flash: { notice: "更新しました" }
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
      redirect_to unchecked_index_admin_orders_path, flash: { notice: "削除しました" }
    else
      redirect_to checked_index_admin_orders_path, flash: { notice: "削除しました" }
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

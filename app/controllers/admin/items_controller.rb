class Admin::ItemsController < AdminController

  private
  def self.save_price
    @item = Item.find(params[:id])
    @item.price = @item.category.price
  end
end

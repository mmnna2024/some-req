class Admin::ItemsController < ApplicationController

  private
  def self.save_price
    @item = Item.find(params[:id])
    @item.price = @item.category.price
  end
end

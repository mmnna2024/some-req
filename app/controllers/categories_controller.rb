class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def update
  end

  def display_update
    checked_ids = params[:category_ids]
    Category.where(id: checked_ids).update_all(display: true)
    Category.where.not(id: checked_ids).update_all(display: false)
    redirect_to categories_url
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_url
  end
end

class CategoriesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  def update
  end

  def display_update
    checked_ids = params[:category_ids]
    Category.where(id: checked_ids).update_all(display: true)
    Category.where.not(id: checked_ids).update_all(display: false)
    redirect_to categories_path
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :price, :display)
  end
end

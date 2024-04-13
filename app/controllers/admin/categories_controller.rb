class Admin::CategoriesController < ApplicationController
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
      redirect_to admin_categories_path, flash: { notice: "カテゴリーを追加しました" }
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
    redirect_to admin_categories_path, flash: { notice: "更新しました" }
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to admin_categories_path, flash: { notice: "削除しました" }
    else
      redirect_to admin_categories_path, flash: { alert: "依頼品に紐づいているため削除できません" }
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :price, :display)
  end
end

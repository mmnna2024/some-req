class Admin::CategoriesController < AdminController
  
  def index
    @categories = Category.all.sort_by_true_latest.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.js
    end
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

  def display_update
    category = Category.find(params[:id])
    category.update(display: !category.display)
    redirect_to admin_categories_path
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

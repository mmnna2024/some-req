class ChangeDisplayDefaltFalseAddCategories < ActiveRecord::Migration[6.1]
  def change
    change_column :categories, :display, :boolean, default: false
  end
end

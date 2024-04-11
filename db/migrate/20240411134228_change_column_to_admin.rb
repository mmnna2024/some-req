class ChangeColumnToAdmin < ActiveRecord::Migration[6.1]
  def change
    change_column_null :admins, :user_id, false
  end
end

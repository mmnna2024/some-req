class AddUserIdToAdmin < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :user_id, :string
  end
end

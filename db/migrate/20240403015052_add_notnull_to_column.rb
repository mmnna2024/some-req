class AddNotnullToColumn < ActiveRecord::Migration[6.1]
  def change
    change_column_null :customers, :name, false
    change_column_null :customers, :phonenumber, false
    change_column_null :customers, :address, false
    change_column_null :orders, :ordered_on, false
    change_column_null :orders, :status, false
    change_column_null :categories, :price, false
    change_column_null :categories, :display, false
    change_column_null :shippings, :name, false
    change_column_null :shippings, :price, false
    # change_column_null :admins, :name, false
    # change_column_null :admins, :password_digest, false
  end
end

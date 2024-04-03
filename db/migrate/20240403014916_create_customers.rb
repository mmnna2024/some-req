class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :phonenumber
      t.string :address
      t.integer :sex
      t.integer :age

      t.timestamps
    end
  end
end

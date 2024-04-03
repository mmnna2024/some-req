class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.datetime :ordered_on
      t.integer :status
      t.integer :channel
      t.integer :price
      t.text :note
      t.references :customer, null: false, foreign_key: true
      t.references :shipping, null: false, foreign_key: true

      t.timestamps
    end
  end
end

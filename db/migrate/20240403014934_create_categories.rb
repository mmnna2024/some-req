class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :price
      t.boolean :display

      t.timestamps
    end
  end
end

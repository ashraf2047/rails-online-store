class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :inventory_count
      t.string :created_by
      t.integer :id

      t.timestamps
    end
  end
end

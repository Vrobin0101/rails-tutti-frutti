class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :category
      t.string :sub_category
      t.text :description
      t.integer :start_month
      t.integer :end_month
      t.boolean :localable

      t.timestamps
    end
  end
end

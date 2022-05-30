class CreateFollowUps < ActiveRecord::Migration[7.0]
  def change
    create_table :follow_ups do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :month_number
      t.float :carbon_calcul
      t.boolean :local
      t.boolean :bio

      t.timestamps
    end
  end
end

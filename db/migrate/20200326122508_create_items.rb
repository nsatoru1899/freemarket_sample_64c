class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :detail, null: false
      t.integer :price, null: false
      t.references :brand, foreign_key: true
      t.integer :status_id, null: false
      t.integer :charge_id, null: false
      t.integer :prefecture_code, null: false
      t.integer :day_id, null: false
      t.references :category, foreign_key: true, null: false
      t.integer :seller, null: false
      t.integer :buyer
      t.timestamps
    end
  end
end

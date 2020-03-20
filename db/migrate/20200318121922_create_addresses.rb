class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.references :user, foreign_key: true, null: false
      t.string :postal_code,  null: false
      t.integer :prefecture_code, null: false
      t.string :city, null: false
      t.string :block, null: false
      t.string :building
      t.timestamps
    end
  end
end

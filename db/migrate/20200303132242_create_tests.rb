class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
      t.text :body
      t.string :image
      t.timestamps
    end
  end
end

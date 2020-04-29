class AddNameToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :name, :string, null:false
    add_column :categories, :ancestry, :string, null:false
    add_index :categories, :ancestry
  end
end

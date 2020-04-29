class AddItemRefToBrands < ActiveRecord::Migration[5.0]
  def change
    add_reference :brands, :item, foreign_key: true
  end
end

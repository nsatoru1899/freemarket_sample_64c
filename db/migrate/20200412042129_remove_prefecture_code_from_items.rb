class RemovePrefectureCodeFromItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :prefecture_code, :integer
  end
end

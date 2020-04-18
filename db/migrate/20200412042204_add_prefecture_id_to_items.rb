class AddPrefectureIdToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :prefecture_id, :integer
  end
end

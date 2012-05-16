class RemoveImageFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :image_id
  end

  def down
  end
end

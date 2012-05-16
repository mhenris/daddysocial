class AddUniquenessIndexToFollows < ActiveRecord::Migration
  def change
    add_index :follows, [:follower_id, :following_id], :unique => true
  end
end

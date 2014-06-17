class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user
      t.text :notification
      t.boolean :is_read

      t.timestamps
    end
    add_index :notifications, :user_id
  end
end

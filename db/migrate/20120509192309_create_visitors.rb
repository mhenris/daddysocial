class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.references :user
      t.integer :visited_by

      t.timestamps
    end
    add_index :visitors, :user_id
  end
end

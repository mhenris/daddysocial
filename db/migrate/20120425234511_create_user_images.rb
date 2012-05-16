class CreateUserImages < ActiveRecord::Migration
  def change
    create_table :user_images do |t|
      t.references :user
      t.boolean :private
      t.string :image

      t.timestamps
    end
  end
end

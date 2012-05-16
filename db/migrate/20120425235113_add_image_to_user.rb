class AddImageToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :user_image
    end
  end
end

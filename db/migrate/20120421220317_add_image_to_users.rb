class AddImageToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :image
    end
  end
end

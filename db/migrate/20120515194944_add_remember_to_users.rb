class AddRememberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_me, :boolean, :default => 0

  end
end

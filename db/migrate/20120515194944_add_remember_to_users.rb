class AddRememberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_me, :boolean, :default => :false

  end
end

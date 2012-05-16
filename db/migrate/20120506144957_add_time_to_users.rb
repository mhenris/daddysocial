class AddTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_login, :datetime

    add_column :users, :last_activity, :datetime

  end
end

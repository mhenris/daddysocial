class AddStuffToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :date

    add_column :users, :weight, :int

    add_column :users, :weight_measurement, :string, :default => "Pounds"

    add_column :users, :country, :string

    add_column :users, :state, :string

    add_column :users, :city, :string

    add_column :users, :zip, :int

    add_column :users, :relationship, :string

    add_column :users, :preferred_age_low, :int

    add_column :users, :preferred_age_high, :int

    add_column :users, :height, :int

    add_column :users, :height_measurement, :string, :default => "inches"

    add_column :users, :sexually, :string

    add_column :users, :profile_text, :text

    add_column :users, :profile_visible_all, :boolean, :default => 0

    add_column :users, :membership_expiration, :date

    add_column :users, :unlimited_membership, :boolean, :default => 0

  end
end

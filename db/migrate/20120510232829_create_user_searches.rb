class CreateUserSearches < ActiveRecord::Migration
  def change
    create_table :user_searches do |t|
      t.references :user
      t.integer :age_low
      t.integer :age_high
      t.string :country
      t.string :state
      t.string :city
      t.string :postal_code
      t.integer :distance
      t.integer :preferred_age_low
      t.integer :preferred_age_high
      t.string :sexually
      t.string :relationship
      t.boolean :online
      t.integer :signup_days
      t.boolean :photo

      t.timestamps
    end
  end
end

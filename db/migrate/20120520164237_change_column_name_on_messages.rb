class ChangeColumnNameOnMessages < ActiveRecord::Migration
  def change
    rename_column :messages, :read, :is_read
  end

end

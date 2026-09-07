class AddColumnToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :buildings_count, :integer, default: 0, null: false
  end
end

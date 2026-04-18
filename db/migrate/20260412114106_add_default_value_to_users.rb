class AddDefaultValueToUsers < ActiveRecord::Migration[8.1]
  def change
    change_column_default :users, :role, from: "user", to: "reader"
  end
end

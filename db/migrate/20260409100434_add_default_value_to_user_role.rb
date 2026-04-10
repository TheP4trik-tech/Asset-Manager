class AddDefaultValueToUserRole < ActiveRecord::Migration[8.1]
  def change
    change_column_default :users, :role, from: nil, to: "user"
  end
end

class RenameCollumnInUsers < ActiveRecord::Migration[8.1]
  def change
    rename_column :buildings, :manager_id, :user_id
  end
end

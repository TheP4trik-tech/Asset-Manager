class RemoveTableModel < ActiveRecord::Migration[8.1]
  def change
    drop_table :models
  end
end

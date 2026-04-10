class AddColummToAuditable < ActiveRecord::Migration[8.1]
  def change
    add_reference :auditables, :user, null: false, foreign_key: {to_table: :users}
  end
end

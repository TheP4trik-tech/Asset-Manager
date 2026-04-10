class CreateAssets < ActiveRecord::Migration[8.1]
  def change
    create_table :assets do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.date :purchase_date, null: false
      t.date :last_check_date, null: false
      t.text :note
      t.decimal :purchase_price
      t.references :room, null: false, foreign_key: { to_table: :rooms }

      t.timestamps
    end
    add_index :assets, :code
  end
end

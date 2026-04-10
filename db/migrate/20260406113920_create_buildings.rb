class CreateBuildings < ActiveRecord::Migration[8.1]
  def change
    create_table :buildings do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :zip_code
      t.string :city
      t.string :street
      t.date :building_date, null: false
      t.string :contact_email, null: false
      t.string :contact_phone, null: false
      t.references :manager , null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :buildings, :code
  end
end

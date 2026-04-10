class CreateRooms < ActiveRecord::Migration[8.1]
  def change
    create_table :rooms do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.date :room_date, null: false
      t.references :building, foreign_key: {to_table: :buildings}, null: false

      t.timestamps
    end
    add_index :rooms, :code
  end
end

class CreateAttachments < ActiveRecord::Migration[8.1]
  def change
    create_table :attachments do |t|
      t.string :attachment_type
      t.text :description
      t.date :added_date
      t.references :asset, null: false, foreign_key: true

      t.timestamps
    end
  end
end

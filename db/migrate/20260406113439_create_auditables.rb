class CreateAuditables < ActiveRecord::Migration[8.1]
  def change
    create_table :auditables do |t|
      t.string :action
      t.json :changed_field
      t.references :auditable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

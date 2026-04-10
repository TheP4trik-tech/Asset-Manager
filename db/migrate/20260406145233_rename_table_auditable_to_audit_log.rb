class RenameTableAuditableToAuditLog < ActiveRecord::Migration[8.1]
  def change
    rename_table :auditables, :audit_logs
  end
end

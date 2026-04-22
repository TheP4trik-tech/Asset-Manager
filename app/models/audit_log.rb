class AuditLog < ApplicationRecord
  belongs_to :auditable, polymorphic: true
  belongs_to :user
  def self.ransackable_attributes(auth_object = nil)
    ["action", "auditable_id", "auditable_type", "changed_field", "created_at", "id", "updated_at", "user_id", "email"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "assets"]
  end
end

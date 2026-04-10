class AuditLog < ApplicationRecord
  belongs_to :auditable, polymorphic: true
  belongs_to :user
end

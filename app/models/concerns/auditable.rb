module Auditable
  extend ActiveSupport::Concern

  included do
    after_create {create_audit_log("Vytvoření")}
    after_update  {create_audit_log("Úprava")}
    after_destroy {create_audit_log("Smazání")}
  end

  private
    def create_audit_log(action)
      return unless Current.user
      AuditLog.create!(auditable: self,
                       user: Current.user,
                       action: action,
                       changed_field: action == "Úprava" ? previous_changes.except("updated_at") : {} )
    end
rescue => e
  Rails.logger.error "AuditLog failed: #{e.message}"

end

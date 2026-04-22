class AuditLogsController < ApplicationController


  def index
    @q = AuditLog.ransack(params[:q])
    @audit_logs = @q.result(distinct: true)

    @pagy, @audit_logs = pagy(@audit_logs)
  end





end
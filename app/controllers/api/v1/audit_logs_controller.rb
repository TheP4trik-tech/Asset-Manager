module Api
  module V1
    class AuditLogsController < ApiController
      def index
        if params[:asset_id].present?
          @asset = Asset.find(params[:asset_id])
          @audit_logs = @asset.audit_logs.order(created_at: :desc)
        else
          @audit_logs = AuditLog.all.order(created_at: :desc)
        end

        render json: @audit_logs
      end

      def show
        @audit_log = AuditLog.find(params[:id])
        render json: @audit_log
      end
    end
  end
end
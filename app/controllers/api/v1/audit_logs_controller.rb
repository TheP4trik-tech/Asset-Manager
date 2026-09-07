module Api
  module V1
    class AuditLogsController < ApiController
      def index
        def index
          @asset = Asset.find(params[:asset_id])
          @audit_logs = @asset.audit_logs.order(created_at: :desc)
          render json: @audit_logs
        end
      end

      def show
        @audit_log = AuditLog.find(params[:id])
        render json: @audit_log
      end
    end
  end
end

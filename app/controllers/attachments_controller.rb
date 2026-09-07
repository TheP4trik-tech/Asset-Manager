class AttachmentsController < ApplicationController
  def create
    @asset = Asset.find(params[:asset_id])
    @attachment = @asset.attachments.build(attachment_params)
    if @attachment.save
      redirect_to asset_path(@asset), notice: "Soubor přidán"
    else
      redirect_to asset_path(@asset), alert: "Prosím vyplňte všechna pole"
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    redirect_to asset_path(@attachment.asset), notice: "File deleted successfully"
  end

  private
  def attachment_params
    params.require(:attachment).permit(:file,  :description, :asset_id, :attachment_type, :added_date)
  end
end

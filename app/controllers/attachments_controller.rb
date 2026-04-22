class AttachmentsController < ApplicationController

  def create
    @asset = Asset.find(params[:asset_id])
    @attachment = @asset.attachments.build(attachment_params)
    if @attachment.save
      redirect_to asset_path(@asset), notice: "File uploaded successfully"
    else
      redirect_to asset_path(@asset), alert: "Please fill out all fields"
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
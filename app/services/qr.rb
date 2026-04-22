class Qr < ApplicationService

  def initialize(asset)
    @asset = asset
  end

  def call
    content = @asset.id.to_s
    qr = RQRCode::QRCode.new(content)
    @qr_code = qr.as_svg(module_size: 5)
  end

end
module CodeGenerator
  extend ActiveSupport::Concern

  private
  def generate_code
    loop do
    self.code = SecureRandom.hex(10)
    break unless Building.exists?(code: code) || Room.exists?(code: code) || Asset.exists?(code: code)
    end
  end

end
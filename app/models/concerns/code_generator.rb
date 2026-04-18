module CodeGenerator
  extend ActiveSupport::Concern

  private

  ## NOT OPTIMAL, YET FUNCTIONING FOR FEW MODELS AND INSTANCES
  def generate_code
    loop do
    self.code = SecureRandom.hex(5)
    break unless [Building, Room, Asset, User].any? { |model| model.exists?(code: code) }
    end
  end

end
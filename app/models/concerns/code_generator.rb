 module CodeGenerator
    extend ActiveSupport::Concern

    included do
      before_validation :generate_code, on: :create
    end

    private
    def generate_code
      loop do
        self.code = SecureRandom.uuid
        break unless self.class.exists?(code: code)
      end
    end
 end
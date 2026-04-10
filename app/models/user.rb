class User < ApplicationRecord
  include CodeGenerator
  enum :role, user: "user", admin: "admin", super_admin: "super_admin"
  has_many :buildings
  has_many :audit_logs, as: :auditable

  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :first_name, :last_name, presence: true, length: 3..20
  validates :phone, length: 3..15
  validates :code, uniqueness: true, presence: true, length: {is:20}
  validates  :role, presence: true

  before_validation :set_api_key if -> { api_key.blank? }
  before_validation :generate_code if -> { code.blank? }

  private
  def set_api_key
    self.api_key = SecureRandom.hex(10)
  end


end

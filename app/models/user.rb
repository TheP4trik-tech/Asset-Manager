class User < ApplicationRecord
  include CodeGenerator
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, reader: "reader", admin: "admin", super_admin: "super_admin"
  has_many :buildings
  has_many :audit_logs, as: :auditable

  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :first_name, :last_name, presence: true, length: 3..20,allow_blank: true
  validates :phone, length: 3..15, allow_blank: true
  validates :code, uniqueness: true, presence: true, length: {is:10}
  validates  :role, presence: true

  before_validation :set_api_key, on: :create
  before_validation :generate_code, on: :create



  def to_s
    "#{first_name} #{last_name}"
  end

  private
  def set_api_key
    self.api_key = SecureRandom.hex(10)
  end


end

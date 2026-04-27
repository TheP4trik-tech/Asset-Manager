class User < ApplicationRecord
  include CodeGenerator
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, reader: "reader", admin: "admin", super_admin: "super_admin"
  has_many :buildings, dependent: :destroy
  has_many :rooms, through: :buildings
  has_many :assets, through: :rooms
  has_many :audit_logs, as: :auditable, dependent: :destroy

  has_many :created_audit_logs, class_name: "AuditLog", foreign_key: "user_id", dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: {with: Devise.email_regexp}
  validates :first_name, :last_name, presence: true, length: 2..20
  validates :phone, length: 3..15, allow_blank: true
  validates :code, uniqueness: true, presence: true
  validates  :role, :api_key, presence: true

  before_validation :set_api_key, on: :create

  scope :ordered, -> { order(last_name: :asc) }
  def to_s
    "#{first_name} #{last_name}"
  end

  private
  def set_api_key
    loop do
      self.api_key = SecureRandom.uuid
      break unless self.class.exists?(api_key: api_key)
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["first_name", "last_name", "email", "phone", "role", "created_at", "updated_at", "code"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["assets", "buildings", "rooms"]
  end


end

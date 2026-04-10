class Building < ApplicationRecord
  include DateValidator, CodeGenerator


  belongs_to :user
  has_many :rooms, dependent: :destroy
  has_many :assets, through: :rooms
  has_many :audit_logs, as: :auditable

  validates :code, uniqueness: true, presence: true, length: {is: 20}
  validates :name, presence: true, length: 3..50
  validates :city, :street, length: 3..50
  validates :zip_code, length: 3..10
  validates :building_date, :user_id, :code , presence: true
  validates :contact_email, presence: true,format: {with: URI::MailTo::EMAIL_REGEXP}, length: 3..50
  validates :contact_phone, presence: true, length: 6..15

  validate {date_not_in_future?(:building_date)}
  before_validation :generate_code if -> { code.blank? }


end

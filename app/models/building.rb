class Building < ApplicationRecord
  include ::DateValidator
  include ::CodeGenerator


  belongs_to :user
  has_many :rooms, dependent: :destroy
  has_many :assets, through: :rooms

  validates :code, uniqueness: true, presence: true, length: {is: 10}
  validates :name, presence: true, length: 3..20
  validates :city, :street, length: 3..20, allow_blank: true
  validates :zip_code, length: 3..10, allow_blank: true
  validates :building_date, :user_id, :code , presence: true
  validates :contact_email, presence: true,format: {with: URI::MailTo::EMAIL_REGEXP}, length: 3..50
  validates :contact_phone, presence: true, length: 6..15

  validate {date_not_in_future?(:building_date)}
  before_validation :generate_code , on: :create


  def self.ransackable_attributes(auth_object = nil)
    ["building_date", "city", "code", "contact_email", "contact_phone", "created_at", "name", "street", "updated_at",  "zip_code", "user_id"]
  end

end

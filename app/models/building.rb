class Building < ApplicationRecord
  include ::DateValidator
  include ::CodeGenerator


  belongs_to :user, counter_cache: true # prevents eager loading
  has_many :rooms, dependent: :destroy
  has_many :assets, through: :rooms

  validates :code, uniqueness: true, presence: true
  validates :name, presence: true, length: 2..20
  validates :city, :street, length: 2..20, allow_blank: true
  validates :zip_code, length: 3..10, allow_blank: true
  validates :building_date, :user_id, :code , presence: true
  validates :contact_email, presence: true,format: {with: Devise.email_regexp}, length: 3..50
  validates :contact_phone, presence: true, length: 6..15


  validate {date_not_in_future?(:building_date)}
  before_validation :generate_code, on: :create

  after_create_commit -> { broadcast_append_to "buildings", partial: "buildings/building", locals: {building: self} }
  after_update_commit -> { broadcast_replace_to "buildings", target: "building_#{id}", partial: "buildings/building", locals: {building: self} }
  after_destroy_commit -> { broadcast_remove_to "buildings", target: "building_#{id}" }

  def self.ransackable_attributes(auth_object = nil)
    ["building_date", "city", "code", "contact_email", "contact_phone", "created_at", "name", "street", "updated_at",  "zip_code", "user_id"]
  end

end

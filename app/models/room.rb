class Room < ApplicationRecord
  include DateValidator, CodeGenerator

  belongs_to :building
  has_many :assets, dependent: :destroy
  has_many :audit_logs, as: :auditable


  validates :code, uniqueness: true, presence: true, length: {is: 20}
  validates :name, presence: true, length: 3..50
  validates :room_date, :building_id, presence: true

  validate {date_not_in_future?(:room_date)}
  before_validation :generate_code if -> { code.blank? }

end

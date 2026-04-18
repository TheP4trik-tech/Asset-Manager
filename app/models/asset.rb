class Asset < ApplicationRecord
  include DateValidator, CodeGenerator

  belongs_to :room
  has_many :attachments, dependent: :destroy
  has_many :audit_logs, as: :auditable

  validates :code, uniqueness: true, presence: true, length: {is: 10 }
  validates :name, presence: true, length: {minimum: 3, maximum: 20}
  validates :room_id, :last_check_date, :purchase_date, presence: true
  validates :note, length: {maximum: 255}
  validates :purchase_price, numericality: {greater_than_or_equal_to: 0}

  validate {date_not_in_future?(:last_check_date)}
  validate {date_not_in_future?(:purchase_date)}

  before_validation :generate_code, on: :create


end

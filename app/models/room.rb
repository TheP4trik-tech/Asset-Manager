class Room < ApplicationRecord
  include DateValidator, CodeGenerator

  belongs_to :building, counter_cache: true
  has_many :assets, dependent: :destroy



  validates :code, uniqueness: true, presence: true
  validates :name, presence: true, length: 2..20
  validates :room_date, :building_id, presence: true

  validate {date_not_in_future?(:room_date)}
  before_validation :generate_code, on: :create

  def self.ransackable_attributes(auth_object = nil)
    ["room_date", "name", "code", "purchase_date", "last_check_date"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["building", "room"]
  end

  ransacker :assets_sum do
    Arel.sql('(SELECT COALESCE(SUM(purchase_price), 0) FROM assets WHERE assets.room_id = rooms.id)')
  end

end

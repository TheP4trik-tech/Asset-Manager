class Attachment < ApplicationRecord
  include DateValidator

  belongs_to :asset
  has_one_attached :file


  validates :added_date, :asset_id, presence: true
  validates :attachment_type, length: {maximum: 20}
  validates :description, length: 0..255

  validate {date_not_in_future?(:added_date)}

end

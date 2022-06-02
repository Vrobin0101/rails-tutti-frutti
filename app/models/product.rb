class Product < ApplicationRecord
  validates :name, :category, :sub_category, :description, :start_month, :end_month, presence: true
  validates :start_month, :end_month, acceptance: { accept: (0..24) }
  has_many :follow_ups
  has_one_attached :photo
  scope :seasonal, ->(month) { where("? > start_month AND ? < end_month", month, month) }


  def season?(month_number)
    (start_month..end_month).include? month_number % 12
  end
end

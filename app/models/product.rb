class Product < ApplicationRecord
  validates :name, :category, :sub_category, :description, :start_month, :end_month, presence: true
  validates :start_month, :end_month, acceptance: { accept: (1..12) }
  has_many :follow_ups
end

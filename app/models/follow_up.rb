class FollowUp < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :month_number, :carbon_calcul, presence: true
  validates :month_number, acceptance: { accept: (0..24) }

  scope :total_score, ->(user) { where(user: user).sum(&:carbon_calcul) }
  scope :total_month_score, ->(user, month = Date.today.month) { where(user: user, month_number: month).sum(&:carbon_calcul) }
end

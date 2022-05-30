class FollowUp < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :month_number, :carbon_calcul, :local, :bio, presence: true
  validates :month_number, acceptance: { accept: (1..12) }
end

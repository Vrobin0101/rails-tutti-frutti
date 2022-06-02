class User < ApplicationRecord
  validates :username, :first_name, :last_name, :city, presence: true

  has_many :follow_ups, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :social_as_asker, class_name: "Social", foreign_key: :asker_id
  has_many :social_as_receiver, class_name: "Social", foreign_key: :receiver_id

  def total_average
    FollowUp.total_score(self).div(self.follow_ups.count)
  end

  def total_month_average
    unless FollowUp.total_month_score(self).zero?
      FollowUp.total_month_score(self).div(self.follow_ups.where(month_number: Date.today.month).count)
    end
  end
end

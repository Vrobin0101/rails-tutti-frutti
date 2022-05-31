class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def profile
    tutti_score_global
    tutti_score_current_month
  end

  private

  def note(score)
    case score
    when 0...20 then 'E'
    when 20...40 then 'D'
    when 40...60 then 'C'
    when 60...80 then 'B'
    when 80..100 then 'A'
    else -1
    end
  end

  def tutti_score_global
    @global_score = current_user.total_average
    @global_note = note(@global_score)
  end

  def tutti_score_current_month
    @current_score = current_user.total_month_average
    @current_note = note(@current_score)
  end
end

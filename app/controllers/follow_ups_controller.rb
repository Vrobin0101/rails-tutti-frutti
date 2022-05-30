class FollowUpsController < ApplicationController

  private

  def set_follow_up
    @follow_up = FollowUp.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def params_follow_up
    params.require(:follow_up).permit(:month_number, :carbon_calcul, :local, :bio)
  end
end

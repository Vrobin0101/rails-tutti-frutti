class FollowUpsController < ApplicationController
  before_action :set_follow_up, only: %i[edit update destroy]
  before_action :set_user, only: %i[create destroy]
  before_action :set_product, only: :create

  def create
    @follow_up = FollowUp.new(params_follow_up)
    @follow_up.user = @user
    @follow_up.product = @product
    @follow_up.month_number = Date.today.month
    @follow_up.carbon_calcul = calcul_follow_up
    authorize @follow_up
    if @follow_up.save
      redirect_to profile_path(@user)
    else
      render :profile, status: :unprocessable_entity
    end
  end

  def edit() end

  def updated
    @follow_up.update(params_follow_up)
    redirect_to profile_path(@user)
  end

  def destroy
    @follow_up.destroy
    redirect_to profile_path(@user), status: :see_other
  end

  private

  def set_follow_up
    @follow_up = FollowUp.find(params[:id])
    authorize @follow_up
  end

  def set_user
    @user = current_user
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def params_follow_up
    params.require(:follow_up).permit(:month_number, :carbon_calcul, :local, :bio)
  end

  def calcul_follow_up
    sum = 0
    sum += 75 if (@product.start_month..@product.end_month).include? @follow_up.month_number
    sum += 15 if @follow_up.local
    sum += 10 if @follow_up.bio
    return sum
  end
end

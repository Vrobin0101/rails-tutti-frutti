class ProductsController < ApplicationController
  before_action :set_product, only: :show
  skip_before_action :authenticate_user!

  def index
    # @products = Product.all
    @products = policy_scope(Product)
    authorize @products
    @current_month = (l Time.now, format: "%B").capitalize
  end

  def show
    @follow_up = FollowUp.new
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end

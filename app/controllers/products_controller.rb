class ProductsController < ApplicationController
  before_action :set_product, only: :show
  skip_before_action :authenticate_user!

  def index
    @products = Product.all
  end

  def show
    @products = Product.all
    @follow_up = FollowUp.new
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end

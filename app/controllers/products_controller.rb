class ProductsController < ApplicationController
  before_action :set_product, only: :show
  skip_before_action :authenticate_user!

  def index
    @products = policy_scope(Product)
    @products = Product.seasonal(Time.now.month)
    if params[:query].present?
      @products = Product.where("name ILIKE ? OR category ILIKE ? OR sub_category ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
      if @products.count == 1
        redirect_to @products.first
      end
    end
    authorize @products
    @current_month = (l Time.now, format: "%B").capitalize
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

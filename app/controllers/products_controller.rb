class ProductsController < ApplicationController
  before_action :set_product, only: :show
  skip_before_action :authenticate_user!

  def index

    if params[:legumes] == "true"
      @legumes_active = ["active", "show active"]
      @fruits_active = []
    elsif params[:fruits] == "true"
      @fruits_active = ["active", "show active"]
      @legumes_active = []
    else
      @legumes_active = []
      @fruits_active = []
    end

    @products = policy_scope(Product)
    authorize @products
    @products = Product.seasonal(Time.now.month).includes([photo_attachment: :blob])
    if params[:query].present?
      @products = Product.includes([photo_attachment: :blob]).where("name ILIKE ? OR category ILIKE ? OR sub_category ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
      if @products.count == 1
        redirect_to @products.first
      end
    end
    @fruits = @products.where(category: 'fruit')
    @legumes = @products.where(category: 'légume')
    @current_month = (l Time.now, format: "%B").capitalize
  end

  def show
    @products = Product.all.includes([photo_attachment: :blob])
    @follow_up = FollowUp.new
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end

class ProductsController < ApplicationController
  before_action :set_product, only: :show
  skip_before_action :authenticate_user!

  def index
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
    @products = Product.seasonal(Time.now.month).includes([photo_attachment: :blob])
    @follow_up = FollowUp.new
    category = Product.find(params[:id]).category
    sub_category = Product.find(params[:id]).sub_category
    name = Product.find(params[:id]).name
    @alternatives = @products.where(category: category, sub_category: sub_category).and(Product.where.not(name: name))
    @alternatives = @products.where(category: category).and(Product.where.not(name: name)) if @alternatives.empty?
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end

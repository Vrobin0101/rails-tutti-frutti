require 'open-uri'
require 'nokogiri'

class ProductsController < ApplicationController
  before_action :set_product, only: :show
  skip_before_action :authenticate_user!

  def index
    set_mois
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
    if params["chosen_month"].present?
      @products = Product.seasonal_double(params["chosen_month"][0], params["chosen_month"][1]).includes([photo_attachment: :blob])
    else
      @products = Product.seasonal(Time.now.month).includes([photo_attachment: :blob])
    end
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
    set_mois
    scrapping
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

  def set_mois
    @mois = ["décembre", "janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"]
  end

  def scrapping
    name = @product.name.tr(
      "ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž",
      "AAAAAAaaaaaaAaAaAaCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOooooooOoOoOoRrRrRrSsSsSsSssTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz")
    url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{name}"
    html = URI.open(url).read
    doc = Nokogiri::HTML(html)
    html_doc = doc.search(".MRTN__sc-1cct3mj-1")
    @recipes = []
    3.times do |index|
      @recipes << { name: html_doc[index].search(".MRTN__sc-30rwkm-0").text, note: html_doc[index].search(".SHRD__sc-10plygc-0").text }
    end
  end
end

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @products = Product.all
    @current_month = (l Time.now, format: "%B").capitalize
  end
end

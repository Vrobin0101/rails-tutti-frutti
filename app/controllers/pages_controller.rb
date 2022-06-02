require 'json'
require 'open-uri'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :map ]

  def home
    @products = Product.all
    @current_month = (l Time.now, format: "%B").capitalize
  end

  def profile
    tutti_score_global
    tutti_score_current_month
  end

  def map
    api_parsing
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

  def api_parsing
    url = "https://opendata.paris.fr/api/records/1.0/search/?dataset=coronavirus-commercants-parisiens-livraison-a-domicile&q=bio&rows=100&facet=code_postal&facet=type_de_commerce&facet=fabrique_a_paris&facet=services"
    @stores = JSON.parse(URI.open(url).read)
    @markers = @stores['records'].map do |e|
      {
        lng: e['fields']['geo_point_2d'][1],
        lat: e['fields']['geo_point_2d'][0],
        image_url: helpers.asset_url("marker_contours_green"),
        id: e['recordid']
      }
    end
  end
end

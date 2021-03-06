require 'json'
require 'open-uri'

# Retrieve your user id and api key from https://htmlcsstoimage.com/dashboard

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[welcome home map export about]
  before_action :set_user, only: %i[profile export]

  def home
    @products = Product.includes([photo_attachment: :blob]).seasonal(Time.now.month)
    @current_month = (l Time.now, format: "%B").capitalize
  end

  def profile
    add_friend if params[:query]
    count_score
    @current_month = (l Time.now, format: "%B").capitalize
    @last_month = (l (Date.today - 1.month), format: "%B").capitalize
    @follows = @user.social_as_receiver + @user.social_as_asker.includes(%i[receiver asker])
    @follows.sort_by!(&:created_at).reverse!
    @follow_ups = @user.follow_ups
    @users = User.pluck(:username).sort.to_json
    @month = Date.today.month
    @month_fo_product = current_user.follow_ups.includes(product: [photo_attachment: :blob]).where(month_number: @month)
  end

  def map
    api_parsing
  end

  def export
    tutti_score_global
    tutti_score_current_month
    tutti_score_last_month
    @current_month = (l Time.now, format: "%B").capitalize
    @last_month = (l (Date.today - 1.month), format: "%B").capitalize
    @follow_ups = @user.follow_ups
  end

  def about
  end

  def welcome
    # redirect_to :home if user_signed_in?
    # line above is commented for the presentation
  end

  private

  def add_friend
    receiver = User.find_by_username(params[:query])
    if receiver.present?
      social = Social.new(asker: current_user, receiver: receiver)
      if social.save
        redirect_to profile_path
      else
        redirect_to profile_path, status: :unprocessable_entity
      end
    else
      redirect_to profile_path, status: :unprocessable_entity
      flash.alert = "Utilisateur inconnu"
    end
  end

  def count_score
    tutti_score_global
    tutti_score_current_month
    tutti_score_last_month
  end

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
    @global_score = @user.total_average
    @global_note = note(@global_score)
  end

  def tutti_score_current_month
    @current_score = @user.total_month_average
    @current_note = note(@current_score)
  end

  def tutti_score_last_month
    @last_score = @user.total_last_month_average
    @last_note = note(@last_score)
  end

  def api_parsing
    url = "https://opendata.paris.fr/api/records/1.0/search/?dataset=coronavirus-commercants-parisiens-livraison-a-domicile&q=bio&rows=100&facet=code_postal&facet=type_de_commerce&facet=fabrique_a_paris&facet=services"
    @stores = JSON.parse(URI.open(url).read)
    @markers = @stores['records'].map do |e|
      {
        lng: e['fields']['geo_point_2d'][1],
        lat: e['fields']['geo_point_2d'][0],
        image_url: helpers.asset_url("marker_map_new.svg"),
        id: e['recordid']
      }
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end

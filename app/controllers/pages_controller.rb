require 'json'
require 'open-uri'

# Retrieve your user id and api key from https://htmlcsstoimage.com/dashboard

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :welcome, :home, :map, :export, :about ]
  before_action :set_user, only: [ :profile, :export]
  def home
    @products = Product.includes([photo_attachment: :blob]).seasonal(Time.now.month)
    @current_month = (l Time.now, format: "%B").capitalize
  end

  def profile
    add_friend if params[:q]
    tutti_score_global
    tutti_score_current_month
    tutti_score_last_month
    @current_month = (l Time.now, format: "%B").capitalize
    @last_month = (l (Date.today - 1.month), format: "%B").capitalize
    @followers = @user.social_as_receiver
    @followings = @user.social_as_asker
    @followings = @followings.includes([:receiver])
    @followers = @followers.includes([:asker])
    @follow_ups = @user.follow_ups
    @users = User.all.pluck(:username).sort.to_json
  end

  def map
    api_parsing
  end

  def export
    # render layout: false
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
  end

  private


  def add_friend
    receiver = User.find_by_username(params[:q])
    if receiver == current_user
      flash.alert = "Vous ne pouvez pas etre amis avec vous meme :)"
    end
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
        image_url: helpers.asset_url("marker_contours_green.png"),
        id: e['recordid']
      }
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end

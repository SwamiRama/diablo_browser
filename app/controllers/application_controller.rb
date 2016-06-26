class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
    session[:locale] = 'de_DE' if session[:locale].nil?
    session[:locale_short] = session[:locale][0..1]
    session[:region] = 'eu' if session[:region].nil?
  end

  def career
    @career ||= DiabloData.perform(session[:region], session[:locale], params[:battle_tag])
  end

  def hero
    @hero ||= DiabloData.perform(session[:region], session[:locale], params[:battle_tag], params[:hero_id])
  end
end

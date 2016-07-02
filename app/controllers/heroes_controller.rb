class HeroesController < ApplicationController
  before_action :career, :hero

  def show
    @portrait = DiabloApi::Icons::Portrait
    @paperdoll = DiabloApi::Icons::Paperdoll
    @item = DiabloApi::Icons::Item
    @tooltip = DiabloApi::Tooltip
    session[:return_to] ||= request.referer
    if hero[:code].present?
      redirect_to session.delete(:return_to)
      flash[:error] = 'Hero not found'
    end
  end
end

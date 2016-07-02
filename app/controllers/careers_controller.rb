class CareersController < ApplicationController
  before_action :career

  def show
    session[:battle_tag] = params[:battle_tag]
    session[:return_to] ||= request.referer
    @portrait = DiabloApi::Icons::Portrait
    if career[:code].present?
      redirect_to session.delete(:return_to)
      flash[:error] = 'BattleTag not found'
    end
  end

  def last_updated
    @career = Career.all.order(:updated_at).limit(10)
  end
end

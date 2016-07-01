class CareersController < ApplicationController
  before_action :career
  
  def show
    session[:battle_tag] = params[:battle_tag]
    @portrait = DiabloApi::Icons::Portrait
  end

  def last_updated
    @career = Career.all.order(:updated_at).limit(10)
  end
end

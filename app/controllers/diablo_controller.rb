class DiabloController < ApplicationController
  def index
  end

  def search
    career = Career.battle_tag(params[:query]).select('battle_tag')
    battle_tags = []
    career.each { |c| battle_tags << c.battle_tag }
    if request.xhr?
      respond_to do |format|
        format.json { render json: battle_tags }
      end
    end
  end
end

class HeroesController < ApplicationController
  before_action :career, :hero
  
  def show
    @portrait = DiabloApi::Icons::Portrait
    @paperdoll = DiabloApi::Icons::Paperdoll
    @item = DiabloApi::Icons::Item
    @tooltip = DiabloApi::Tooltip
  end
end

class DiabloApiData
  attr_reader :region, :locale, :battle_tag, :hero_id

  class << self
    def perform(region, locale, battle_tag, hero_id = nil)
      instance = new(region, locale, battle_tag, hero_id)
      instance.perform
    end
  end

  def initialize(region, locale, battle_tag, hero_id)
    @region = region
    @locale = locale
    @battle_tag = battle_tag.downcase
    @hero_id = hero_id
  end

  def perform
    data
  end

  private

  def data
    return @data ||= DiabloApi::Career.new(@region, @locale, @battle_tag) if @hero_id.nil?
    @data ||= DiabloApi::Hero.new(@region, @locale, @battle_tag, @hero_id)
  end
end

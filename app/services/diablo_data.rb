class DiabloData
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
    if data_exists?
      return process_data if data_expired?
      data
    else
      process_data
    end
  end

  private

  def data_exists?
    return Career.exists?(['battle_tag ~* ?', @battle_tag]) if @hero_id.nil?
    Hero.exists?(id: @hero_id)
  end

  def career
    return (@career_data ||= HandleCareerData.perform(career_api.data)) if Career.battle_tag(@battle_tag).first.nil?
    @career_data ||= Career.battle_tag(@battle_tag).first
  end

  def hero
    @hero ||= Hero.find @hero_id
  end

  def data
    return (@data ||= career) if @hero_id.nil?
    @data ||= hero
  end

  def data_expired?
    data.updated_at < (Date.today - 1.day)
  end

  def process_data
    return HandleCareerData.perform(career_api.data) if @hero_id.nil?
    HandleHeroData.perform(career, hero_api.data)
  end

  def career_api
    @career_api ||= DiabloApiData.perform(@region, @locale, @battle_tag)
  end

  def hero_api
    @hero_api ||= DiabloApiData.perform(@region, @locale, @battle_tag, @hero_id)
  end
end

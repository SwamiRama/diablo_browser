class HandleCareerData
  attr_reader :data

  class << self
    def perform(data)
      instance = new(data)
      instance.perform
    end
  end

  def initialize(data)
    @data = data
  end

  def perform
    return data unless data[:code].nil?
    return update_career if Career.battle_tag(@data[:battle_tag]).present?
    save_career
  end

  private

  def career
    @career ||= Career.battle_tag(@data[:battle_tag]).first
  end

  def save_career
    Career.new(@data).save!
    career
  end

  def update_career
    model = Career.battle_tag(@battle_tag).first
    model.battle_tag = @data[:battle_tag]
    model.paragon_level = @data[:paragon_level]
    model.paragon_level_hardcore = @data[:paragon_level_hardcore]
    model.paragon_level_season = @data[:paragon_level_season]
    model.paragon_level_season_hardcore = @data[:paragon_level_season_hardcore]
    model.guild_name = @data[:guild_name]
    model.heroes = @data[:heroes]
    model.last_hero_played = @data[:last_hero_played]
    model.last_updated = @data[:last_updated]
    model.kills = @data[:kills]
    model.highest_hardcore_level = @data[:highest_hardcore_level]
    model.time_played = @data[:time_played]
    model.progression = @data[:progression]
    model.fallen_heroes = @data[:fallen_heroes]
    model.blacksmith = @data[:blacksmith]
    model.jeweler = @data[:jeweler]
    model.mystic = @data[:mystic]
    model.blacksmith_hardcore = @data[:blacksmith_hardcore]
    model.jeweler_hardcore = @data[:jeweler_hardcore]
    model.mystic_hardcore = @data[:mystic_hardcore]
    model.blacksmith_season = @data[:blacksmith_season]
    model.jeweler_season = @data[:jeweler_season]
    model.mystic_season = @data[:mystic_season]
    model.blacksmith_season_hardcore = @data[:blacksmith_season_hardcore]
    model.jeweler_season_hardcore = @data[:jeweler_season_hardcore]
    model.mystic_season_hardcore = @data[:mystic_season_hardcore]
    model.seasonal_profiles = @data[:seasonal_profiles]
    model.created_at = Time.current if model.created_at.nil?
    model.updated_at = Time.current
    model.save!
    career
  end
end

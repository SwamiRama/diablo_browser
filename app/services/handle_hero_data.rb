class HandleHeroData
  attr_reader :career, :data, :hero

  class << self
    def perform(career, data)
      instance = new(career, data)
      instance.perform
    end
  end

  def initialize(career, data)
    @career = career
    @data = data
  end

  def perform
    return data unless data[:code].nil?
    return update_hero if Hero.exists?(@data[:id])
    save_hero
  end

  private

  def hero
    @hero ||= Hero.find(@data[:id])
  end

  def save_hero
    new_hero = Hero.new
    new_hero.career_id = @career.id
    new_hero.name = @data[:name]
    new_hero.hero_class = @data[:class]
    new_hero.gender = @data[:gender]
    new_hero.level = @data[:level]
    new_hero.kills = @data[:kills]
    new_hero.paragon_level = @data[:paragon_level]
    new_hero.season_created = @data[:season_created]
    new_hero.skills = @data[:skills]
    new_hero.items = @data[:items]
    new_hero.followers = @data[:followers]
    new_hero.legendary_powers = @data[:legendary_powers]
    new_hero.stats = @data[:stats]
    new_hero.progression = @data[:progression]
    new_hero.hardcore = @data[:hardcore]
    new_hero.seasonal = @data[:seasonal]
    new_hero.dead = @data[:dead]
    new_hero.last_updated = @data[:last_updated]
    new_hero.save!
    new_hero.id = @data[:id]
    new_hero.save!
    new_hero
  end

  def update_hero
    model = hero
    model.career_id = @career.id
    model.name = @data[:name]
    model.hero_class = @data[:class]
    model.gender = @data[:gender]
    model.level = @data[:level]
    model.kills = @data[:kills]
    model.paragon_level = @data[:paragon_level]
    model.season_created = @data[:season_created]
    model.skills = @data[:skills]
    model.items = @data[:items]
    model.followers = @data[:followers]
    model.legendary_powers = @data[:legendary_powers]
    model.stats = @data[:stats]
    model.progression = @data[:progression]
    model.hardcore = @data[:hardcore]
    model.seasonal = @data[:seasonal]
    model.dead = @data[:dead]
    model.last_updated = @data[:last_updated]
    model.save!
    model.id = @data[:id]
    model.created_at = Time.current if model.created_at.nil?
    model.updated_at = Time.current
    model.save!
    hero
  end
end

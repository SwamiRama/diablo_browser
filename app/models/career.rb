class Career < ApplicationRecord
  has_many :heros

  serialize :heroes
  serialize :kills
  serialize :time_played
  serialize :progression
  serialize :fallen_heroes
  serialize :blacksmith
  serialize :jeweler
  serialize :mystic
  serialize :blacksmith_hardcore
  serialize :jeweler_hardcore
  serialize :mystic_hardcore
  serialize :blacksmith_season
  serialize :jeweler_season
  serialize :mystic_season
  serialize :blacksmith_season_hardcore
  serialize :jeweler_season_hardcore
  serialize :mystic_season_hardcore
  serialize :seasonal_profil

  scope :battle_tag, -> (battle_tag) { where('battle_tag ~* ?', battle_tag.to_s) }
end

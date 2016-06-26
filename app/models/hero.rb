class Hero < ApplicationRecord
  belongs_to :career

  serialize :name
  serialize :class
  serialize :gender
  serialize :level
  serialize :kills
  serialize :paragon_level
  serialize :hardcore
  serialize :seasonal
  serialize :season_created
  serialize :skills
  serialize :items
  serialize :followers
  serialize :legendary_powers
  serialize :stats
  serialize :progression
  serialize :dead
  serialize :last_updated
end

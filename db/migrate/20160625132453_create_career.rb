class CreateCareer < ActiveRecord::Migration[5.0]
  def change
    create_table :careers do |t|
      t.string :battle_tag
      t.integer :paragon_level
      t.integer :paragon_level_hardcore
      t.integer :paragon_level_season
      t.integer :paragon_level_season_hardcore
      t.string :guild_name
      t.text :heroes
      t.integer :last_hero_played
      t.integer :last_updated
      t.text :kills
      t.integer :highest_hardcore_level
      t.text :time_played
      t.text :progression
      t.text :fallen_heroes
      t.text :blacksmith
      t.text :jeweler
      t.text :mystic
      t.text :blacksmith_hardcore
      t.text :jeweler_hardcore
      t.text :mystic_hardcore
      t.text :blacksmith_season
      t.text :jeweler_season
      t.text :mystic_season
      t.text :blacksmith_season_hardcore
      t.text :jeweler_season_hardcore
      t.text :mystic_season_hardcore
      t.text :seasonal_profiles

      t.timestamps null: false
    end
  end
end

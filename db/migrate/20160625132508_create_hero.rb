class CreateHero < ActiveRecord::Migration[5.0]
  def change
    create_table :heros do |t|
      t.integer :career_id
      t.string :name
      t.string :hero_class
      t.integer :gender
      t.integer :level
      t.text :kills
      t.text :paragon_level
      t.string :hardcore
      t.string :seasonal
      t.integer :season_created
      t.text :skills
      t.text :items
      t.text :followers
      t.text :legendary_powers
      t.text :stats
      t.text :progression
      t.string :dead
      t.integer :last_updated

      t.timestamps null: false
    end
  end
end

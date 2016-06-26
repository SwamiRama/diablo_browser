namespace :diablo do
  desc "seed diablo data"
  task seed: :environment do
    battle_tags = [ 'Jimmi#2787',
                    'dcdead#2260',
                    'jahddict#2829',
                    'bonecrumbler#2434',
                    'ilovemf#2998',
                    'avnor#2601',
                    'fury#2378',
                    'lynk123#2590',
                    'bunch#2760',
                    'kaiser#1982',
                    'farky#2571',
                    'lemon8#2400',
                    'rockschwein#2801',
                    'madawc#2708',
                    'rafcior#2591',
                    'bloodhunter#2226',
                    'actionfunk#1894',
                    'sabre#2198',
                    'padonak#1320' ]
    battle_tags.each do |tag|
      career_api = DiabloApiData.perform('eu', 'en_GB', tag)
      HandleCareerData.perform(career_api.data)
      puts "#{tag} done!"
    end
  end

end

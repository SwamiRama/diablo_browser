require "rails_helper"

describe HandleHeroData do
  let(:career) { HandleCareerData.perform(DiabloApiData.perform('eu', 'de_DE', 'Jimmi#2787').data) }
  context 'new Hero' do
    let(:diablo_data) { DiabloApiData.perform('eu', 'de_DE', 'Jimmi#2787', '8872068') }
    it "create a new Hero" do
      expect {described_class.perform(career, diablo_data.data)}.to change{Hero.count}.from(0).to(1)
    end
  end
  context 'update Hero' do
    let(:diablo_data) { DiabloApiData.perform('eu', 'de_DE', 'Jimmi#2787', '8872068') }
    it {
      Timecop.freeze(Time.now)
      described_class.perform(career, diablo_data.data)
      Hero.first.update(updated_at: '1-01-01')
      expect {described_class.perform(career, diablo_data.data)}.to_not change(Hero, :count)
      expect(Hero.first.updated_at.utc.to_s).to eq(Time.now.utc.to_s)
      Timecop.return
    }
  end

  let(:diablo_data) { DiabloApiData.perform('eu', 'de_DE', 'Jimmi#2787', '123456') }
  context 'wrong battle_tag' do
    let(:career) { described_class.perform(HandleCareerData.perform(DiabloApiData.perform('eu', 'de_DE', 'Jimmi#2787').data), diablo_data.data) }
    it "expect an error code" do
      expect(career).to eq({:code=>"NOTFOUND", :reason=>"The account could not be found."})
    end
  end
end

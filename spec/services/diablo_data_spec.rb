require "rails_helper"

describe DiabloData do
  context 'without hero_id (Career)' do
    subject(:diablo_data) { described_class.perform('eu', 'de_DE', 'Jimmi#2787') }
    it { expect{ diablo_data }.to change{Career.count}.from(0).to(1) }
    it 'has expired' do
      past_time = Time.now - 30.days
      Timecop.freeze(Time.now)
      diablo_data.update(updated_at: past_time)
      expect {diablo_data}.to_not change(Career, :count)
      described_class.perform('eu', 'de_DE', 'Jimmi#2787')
      expect(Career.first.updated_at.utc.to_s).to eq(Time.now.utc.to_s)
    end
    it 'has not expired' do
      past_time = Time.now - 30.minutes
      Timecop.freeze(Time.now)
      diablo_data.update(updated_at: past_time)
      expect {diablo_data}.to_not change(Career, :count)
      expect(Career.first.updated_at.utc.to_s).to eq(past_time.utc.to_s)
    end
  end
  context 'with hero_id (Hero)' do
    subject(:diablo_data) { described_class.perform('eu', 'de_DE', 'Jimmi#2787', '8872068') }
    it { expect { diablo_data }.to change{Hero.count}.from(0).to(1)}
    it 'has expired' do
      past_time = Time.now - 30.days
      Timecop.freeze(Time.now)
      diablo_data.update(updated_at: past_time)
      expect {diablo_data}.to_not change(Hero, :count)
      described_class.perform('eu', 'de_DE', 'Jimmi#2787', '8872068')
      expect(Hero.first.updated_at.utc.to_s).to eq(Time.now.utc.to_s)
    end
    it 'has not expired' do
      past_time = Time.now - 30.minutes
      Timecop.freeze(Time.now)
      diablo_data.update(updated_at: past_time)
      described_class.perform('eu', 'de_DE', 'Jimmi#2787', '8872068')
      expect {described_class.perform('eu', 'de_DE', 'Jimmi#2787', '8872068')}.to_not change(Hero, :count)
      expect(Hero.first.updated_at.utc.to_s).to eq(past_time.utc.to_s)
    end
  end
  context 'wrong battle_tag' do
    subject(:diablo_data) { described_class.perform('eu', 'de_DE', 'Jimmi#2787', '1') }
    it "has an error code" do
      expect(diablo_data).to eq({:code=>"NOTFOUND", :reason=>"The account could not be found."})
    end
  end
end

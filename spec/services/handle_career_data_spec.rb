require "rails_helper"

describe HandleCareerData do
  let(:diablo_data) { DiabloApiData.perform('eu', 'de_DE', 'Jimmi#2787') }
  context 'new Career' do
    it { expect {described_class.perform(diablo_data.data)}.to change{Career.count}.from(0).to(1) }
  end
  context 'update Career' do
    it {
      Timecop.freeze(Time.now)
      described_class.perform(diablo_data.data)
      Career.first.update(updated_at: '1-01-01')
      expect {described_class.perform(diablo_data.data)}.to_not change(Career, :count)
      expect(Career.first.updated_at.utc.to_s).to eq(Time.now.utc.to_s)
      Timecop.return
    }
  end

  let(:diablo_data) { DiabloApiData.perform('eu', 'de_DE', 'abcdefg') }
  context 'wrong battle_tag' do
    let(:career) { HandleCareerData.perform(diablo_data.data) }
    it "expect an error code" do
      expect(career).to eq({:code=>"NOTFOUND", :reason=>"The account could not be found."})
    end
  end
end

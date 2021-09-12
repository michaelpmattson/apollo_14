require 'rails_helper'

describe Mission, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :time_in_space }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many(:astronauts).through(:astronaut_missions)}
  end

  before(:each) do
    @gemini7    = Mission.create!(title: "Gemini 7", time_in_space: 6545646)
    @capricorn4 = Mission.create!(title: "Capricorn 4", time_in_space: 6518946)
    @apollo13   = Mission.create!(title: "Apollo 13", time_in_space: 1654684)
  end

  describe '.class methods' do
    describe '.alpha_sort' do
      it 'sorts missions alphabetically' do
        expect(Mission.alpha_sort).to eq([@apollo13, @capricorn4, @gemini7])
      end
    end
  end
end

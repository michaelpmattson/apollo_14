require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many(:missions).through(:astronaut_missions) }
  end

  before(:each) do
    @neil = Astronaut.create!(name: 'Neil Armstrong', age: 37, job: 'Commander')
    @buzz = Astronaut.create!(name: 'Buzz Aldrin', age: 39, job: 'Lunar module pilot')
    @mike = Astronaut.create!(name: 'Michael Collins', age: 39, job: 'Command module pilot')

    @apollo13   = Mission.create!(title: "Apollo 13", time_in_space: 10)
    @capricorn4 = Mission.create!(title: "Capricorn 4", time_in_space: 20)
    @gemini7    = Mission.create!(title: "Gemini 7", time_in_space: 25)

    @apollo13.astronauts << @mike
    @apollo13.astronauts << @buzz

    @capricorn4.astronauts << @mike
    @capricorn4.astronauts << @neil

    @gemini7.astronauts << @mike
    @gemini7.astronauts << @neil
    @gemini7.astronauts << @buzz
  end

  describe '#instance methods' do
    describe '#total_time_in_space' do
      it 'returns total time in space' do
        expect(@neil.total_time_in_space).to eq(45)
      end
    end
  end

  describe '.class methods' do
    describe '.average_age' do
      it 'calculates average age' do
        expect(Astronaut.average_age).to eq(38.33)
      end
    end
  end
end

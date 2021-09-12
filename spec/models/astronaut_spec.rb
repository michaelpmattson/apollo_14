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
  end

  describe '#instance methods' do
    describe '#details' do
      it 'returns a string of the name age and job' do
        expect(@neil.details).to eq("Name: Neil Armstrong, Age: 37, Job: Commander")
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

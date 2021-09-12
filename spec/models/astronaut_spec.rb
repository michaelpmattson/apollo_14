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

  describe '#instance methods' do
    describe '#details' do
      it 'returns a string of the name age and job' do
        neil = Astronaut.create!(name: 'Neil Armstrong', age: 37, job: 'Commander')

        expect(neil.details).to eq("Name: Neil Armstrong, Age: 37, Job: Commander")
      end
    end
  end
end

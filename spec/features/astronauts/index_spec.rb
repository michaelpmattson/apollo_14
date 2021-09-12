require 'rails_helper'

RSpec.describe 'the astronauts index page' do
  context 'when I visit the index' do
    before(:each) do
      @neil = Astronaut.create!(name: 'Neil Armstrong', age: 37, job: 'Commander')
      @buzz = Astronaut.create!(name: 'Buzz Aldrin', age: 39, job: 'Lunar module pilot')

      visit '/astronauts'
    end

    it 'has a list of astronauts name age and jobs' do
      expect(page).to have_content("Name: Neil Armstrong, Age: 37, Job: Commander")
      expect(page).to have_content("Name: Buzz Aldrin, Age: 39, Job: Lunar module pilot")
    end
  end
end

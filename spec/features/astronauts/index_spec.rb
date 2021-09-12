require 'rails_helper'

RSpec.describe 'the astronauts index page' do
  context 'when I visit the index' do
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

      visit '/astronauts'
    end

    it 'has a list of astronauts name age and jobs' do
      expect(page).to have_content("Name: Neil Armstrong, Age: 37, Job: Commander")
      expect(page).to have_content("Name: Buzz Aldrin, Age: 39, Job: Lunar module pilot")
      expect(page).to have_content("Name: Michael Collins, Age: 39, Job: Command module pilot")
    end

    it 'shows the average age of all astronauts' do
      expect(page).to have_content("Average Age: 38.33")
    end

    it 'shows an alphabetical list of missions for each astronaut' do
      within "#astronaut-#{@neil.id}" do
        expect("Capricorn 4").to appear_before("Gemini 7")
      end

      within "#astronaut-#{@buzz.id}" do
        expect("Apollo 13").to appear_before("Gemini 7")
      end

      within "#astronaut-#{@mike.id}" do
        expect("Apollo 13").to appear_before("Capricorn 4")
        expect("Capricorn 4").to appear_before("Gemini 7")
      end
    end

    it 'has the total time in space for each astronaut' do
      expect(page).to have_content("Name: Neil Armstrong, Age: 37, Job: Commander, Total Time in Space: 45 days")
      expect(page).to have_content("Name: Buzz Aldrin, Age: 39, Job: Lunar module pilot, Total Time in Space: 35 days")
      expect(page).to have_content("Name: Michael Collins, Age: 39, Job: Command module pilot, Total Time in Space: 55 days")
    end
  end
end

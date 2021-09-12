require 'rails_helper'

RSpec.describe 'the astronauts index page' do
  context 'when I visit the index' do
    before(:each) do
      @neil = Astronaut.create!(name: 'Neil Armstrong', age: 37, job: 'Commander')
      @buzz = Astronaut.create!(name: 'Buzz Aldrin', age: 39, job: 'Lunar module pilot')
      @mike = Astronaut.create!(name: 'Michael Collins', age: 39, job: 'Command module pilot')

      @apollo13   = Mission.create!(title: "Apollo 13", time_in_space: 1654684)
      @capricorn4 = Mission.create!(title: "Capricorn 4", time_in_space: 6518946)
      @gemini7    = Mission.create!(title: "Gemini 7", time_in_space: 6545646)

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
      save_and_open_page
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
  end
end

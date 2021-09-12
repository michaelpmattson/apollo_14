class AstronautMission < ApplicationRecord
  has_many :astronauts
  has_many :missions
end

class Astronaut < ApplicationRecord
  has_many :astronaut_missions
  has_many :missions, through: :astronaut_missions

  validates_presence_of :name, :age, :job

  def total_time_in_space
    missions.total_time_in_space
  end

  def self.average_age
    average(:age).to_f.round(2)
  end
end

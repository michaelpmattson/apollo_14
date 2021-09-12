class Astronaut < ApplicationRecord
  has_many :astronaut_missions
  has_many :missions, through: :astronaut_missions

  validates_presence_of :name, :age, :job

  def details
    "Name: #{name}, Age: #{age}, Job: #{job}"
  end

  def self.average_age
    average(:age).to_f.round(2)
  end
end

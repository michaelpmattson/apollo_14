class Mission < ApplicationRecord
  has_many :astronaut_missions
  has_many :astronauts, through: :astronaut_missions

  validates_presence_of :title, :time_in_space

  def self.alpha_sort
    order(:title)
  end
end

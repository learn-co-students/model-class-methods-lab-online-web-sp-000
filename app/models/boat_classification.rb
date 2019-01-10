class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

  def self.sailboats
    sailboat = Classification.sailboats.pluck(:id)
    where("classification_id =?", sailboat)
  end

  def self.longest_boat_classifications
    longest = Boat.longest.pluck(:id)
    BoatClassification.where(boat_id: longest).pluck(:classification_id)
  end
end
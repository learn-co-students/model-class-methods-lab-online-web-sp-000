class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    # all
    classification = self.all
    classification
  end

  def self.longest
    # Boat.longest.classifications
    classification = Boat.order('length DESC').first
    classification.classifications
  end

end

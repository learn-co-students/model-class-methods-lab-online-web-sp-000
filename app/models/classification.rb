class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.sailboats
    where("name = ?", "Sailboat")
  end

  def self.catamaran
    self.find_by(name: "Catamaran")
  end

  def self.motorboat
    self.find_by(name: "Motorboat")
  end

  def self.my_all
    all
  end

  def self.longest
    classification_ids = BoatClassification.longest_boat_classifications
    where(id: classification_ids)
  end
end

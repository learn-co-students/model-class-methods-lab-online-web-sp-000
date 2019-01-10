class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5)
  end
  
  def self.dinghy
    where("length <?", 20)
  end

  def self.ship
    where("length >=?", 20)
  end

  def self.longest
    order(length: :desc).limit(1)
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    sailboats = BoatClassification.sailboats.pluck(:boat_id)
    where(id: sailboats)
  end

  def self.with_three_classifications
    boat_ids = self.all.select {|b| b.classification_ids.count == 3}.map {|b| b.id}
    where(id: boat_ids)
  end

  def self.catamarans
    Classification.catamaran.boats
  end
  
  def self.motorboats
    Classification.motorboat.boats
  end
end

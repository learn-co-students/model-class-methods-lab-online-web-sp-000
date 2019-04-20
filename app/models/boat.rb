class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  
  def self.first_five 
    self.all.limit(5)
  end 
  
  def self.dinghy 
    Boat.where("Length < ?", 20)
  end
  
  def self.ship 
    Boat.where("Length > ?", 20)
  end
  
  def self.last_three_alphabetically 
    self.order(name: :desc).limit(3)
  end 
  
  def self.without_a_captain 
    self.where(captain: nil)
  end 
  
  def self.sailboats 
    self.joins(:classifications).where(classifications: { name: "Sailboat"})
  end 
  
  def self.with_three_classifications 
    self.all.select { |boat| boat if boat.classifications.size == 3 }
  end 
  
end

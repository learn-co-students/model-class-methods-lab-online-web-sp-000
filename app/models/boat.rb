class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.limit(5)
  end

  def self.dinghy
    Boat.select { |boat| boat.length < 20 }
  end

  def self.ship
    Boat.select { |boat| boat.length >= 20 }
  end

  def self.last_three_alphabetically
    Boat.order('name DESC').limit(3)
  end

  def self.without_a_captain
    Boat.where("captain_id IS NULL")
  end

  def self.sailboats
    Boat.select { |boat| boat.classifications.any? { |classification| classification.name == "Sailboat" } }
  end

  def self.catamarans
    Boat.select { |boat| boat.classifications.any? { |classification| classification.name == "Catamaran" } }
  end

  def self.motorboats
    Boat.select { |boat| boat.classifications.any? { |classification| classification.name == "Motorboat" } }
  end

  def self.with_three_classifications
    Boat.select { |boat| boat.classifications.count == 3 }
  end

  def self.longest
    Boat.order('length DESC').limit(1).first
  end
end

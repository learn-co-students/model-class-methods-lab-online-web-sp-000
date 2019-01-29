class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.select(:all).limit(5)
  end

  def self.dinghy
    Boat.select(:all).where("length < 20" )
  end

  def self.ship
    Boat.select(:all).where("length >= 20" )
  end

  def self.last_three_alphabetically
    Boat.order('name DESC').limit(3)
  end

  def self.without_a_captain
    Boat.where(captain_id: nil)
  end

  def self.sailboats
    Boat.includes(:classifications).where('classifications.name = ?', 'Sailboat').references(:classifications)
  end

  def self.with_three_classifications
    Boat.includes(:classifications).group(:boat_id).having("COUNT(*) = 3")
  end
end

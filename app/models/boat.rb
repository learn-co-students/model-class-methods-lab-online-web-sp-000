class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def self.first_five
    limit(5).order('id')
  end

  def self.dinghy
    where("length < ?", 20)
  end

  def self.ship
    where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    limit(3).order('name desc')
  end

  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
    self.joins(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.catamarans
    self.joins(:classifications).where(classifications: {name: "Catamaran"})
  end

  def self.with_three_classifications
    self.joins(:classifications).group(:boat_id).having("COUNT(*) = 3")
  end

end

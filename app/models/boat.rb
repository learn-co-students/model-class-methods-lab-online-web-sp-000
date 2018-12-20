class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    order(:created_at)
      .limit(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    order(name: :desc)
      .limit(3)
  end

  def self.without_a_captain
    where("captain_id is null")
  end

  def self.sailboats
    self.joins(:classifications)
      .where("classifications.name = 'Sailboat'")
  end

  def self.with_three_classifications
    self.joins(:boat_classifications)
      .group(:name)
      .having('COUNT(classification_id) = 3')
  end

  def self.longest
    self.order(length: :desc)
      .limit(1)
  end
end

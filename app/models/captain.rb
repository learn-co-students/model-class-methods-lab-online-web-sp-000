class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
      joins(boats: [:classifications]).where(classifications: {name: "Catamaran"}).uniq
  end


  def self.sailors
    joins(boats: [:classifications]).where(classifications: {name: "Sailboat"}).uniq
  end


  def self.talented_seafarers
      self.joins(boats: [:classifications]).where("classifications.name IN ('Sailboat', 'Motorboat')").group("captains.id").having("count(DISTINCT classifications.name) >= ?", 2)
    end

  def self.non_sailors
    where("id NOT IN (?)", self.sailors.pluck(:id))
  end

end

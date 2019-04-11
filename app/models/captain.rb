class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
      joins(boats: [:classifications]).where(classifications: {name: "Catamaran"}).uniq
  end

  def self.motorboat
     joins(boats: :classifications).where(classifications: { name: "Motorboat"} ).uniq
  end

  def self.sailors
    joins(boats: [:classifications]).where(classifications: {name: "Sailboat"}).uniq
  end


  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat.pluck(:id))
  end

  def self.non_sailors
    where("id NOT IN (?)", self.sailors.pluck(:id))
  end

end

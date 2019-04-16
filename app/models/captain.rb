class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: [:classifications]).merge(Classification.where(name: "Catamaran"))
  end

  def self.sailors
    self.joins(boats: [:classifications]).merge(Classification.where(name: "Sailboat").distinct)
  end

  def self.motorists
    self.joins(boats: [:classifications]).merge(Classification.where(name: "Motorboat").distinct)
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorists.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end

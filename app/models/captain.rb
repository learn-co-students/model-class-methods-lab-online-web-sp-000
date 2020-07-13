class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # includes(boats: :classifications).where(classifications: {name: "Catamaran"})
    captains = self.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
    captains
  end

  def self.sailors
    # includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
    captains = self.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
    captains
  end

  def self.motorboat_operators
    # includes(boats: :classifications).where(classifications: {name: "Motorboat"})
    captains = self.includes(boats: :classifications).where(classifications: {name: "Motorboat"})
    captains
  end

  def self.talented_seafarers
    # where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
    captains = self.where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
    captains
  end

  def self.non_sailors
    # where.not("id IN (?)", self.sailors.pluck(:id))
    captains = self.where.not("id IN (?)", self.sailors.pluck(:id))
    captains
  end

end

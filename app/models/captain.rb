class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    Captain.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seafarers
    Captain.where("name IN (?)", self.sailors.pluck(:name) & Captain.includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq.pluck(:name))
  end

  def self.non_sailors
    Captain.where.not("name IN (?)", self.sailors.pluck(:name))
  end
end

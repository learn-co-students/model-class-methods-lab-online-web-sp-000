class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: [:classifications])
      .where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    self.joins(boats: [:classifications])
      .where("classifications.name = 'Sailboat'")
      .group(:name)
  end

  def self.talented_seafarers
    self.joins(boats: :classifications)
      .where("classifications.name IN ('Motorboat', 'Sailboat')")
      .group('captains.name')
      .having('COUNT(DISTINCT(classifications.name)) = 2')
  end

  def self.non_sailors
    self.where("id NOT IN (?)", self.sailors.pluck(:id))
  end
end
require 'pry'
class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: [:classifications]).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
    self.joins(boats: [:classifications]).where("classifications.name = ?", "Sailboat").distinct
  end

  def self.talented_seafarers
    self.joins(boats: [:classifications]).where("classifications.name IN ('Sailboat', 'Motorboat')").group("captains.id").having("count(DISTINCT classifications.name) >= ?", 2)
  end

  def self.non_sailors
    sailors_ids = self.sailors.pluck(:id)
    self.where("id NOT IN (?)", sailors_ids)
  end

end

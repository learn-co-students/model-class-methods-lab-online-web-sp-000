class Captain < ActiveRecord::Base
  has_many :boats

  ##returns captains of catamarans
  def self.catamaran_operators
    joins(boats: [:classifications]).where("classifications.name = ?", "Catamaran").distinct
  end

  ##returns captains with sailboats
  def self.sailors
    joins(boats: [:classifications]).where("classifications.name = ?", "Sailboat").distinct
  end

  ##returns captains with motorboats
  def self.motorboat_operators
    joins(boats: [:classifications]).where("classifications.name = ?", "Motorboat").distinct
  end

  ##returns captains of motorboats and sailboats
  def self.talented_seafarers
    all.where("ID IN(?)", sailors.pluck(:id) & motorboat_operators.pluck(:id))
  end

  ##returns people who are not captains of sailboats
  def self.non_sailors
    all.where("ID NOT IN(?)", sailors.pluck(:id))
  end

end

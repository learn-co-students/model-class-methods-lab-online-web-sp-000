class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(:boats).where (includes(:classifications).where('classifications.name=?', 'Catamaran').references(:classifications).references(:boats))
    
  end

  def self.sailors
    sailboat = Classification.find_by(name: "Sailboat")
  end

  def self.talented_seafarers
    sailboat = Classification.find_by(name: "Sailboat")
    motorboat = Classification.find_by(name: "Motorboat")
  end
  
  def self.non_sailors
    sailboat = Classification.find_by(name: "Sailboat")
  end

end

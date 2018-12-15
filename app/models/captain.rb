class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
    Captain.joins(boats: :classifications).where('classifications.name' => 'Catamaran')
  end

  def self.sailors
    Captain.joins(boats: :classifications).where('classifications.name' => 'Sailboat').distinct
  end

  def self.motorists
    Captain.joins(boats: :classifications).where('classifications.name' => 'Motorboat').distinct
  end

  def self.talented_seafarers
    Captain.where("id IN (?) and id IN (?)", self.sailors.pluck(:id), self.motorists.pluck(:id))
  end

  def self.non_sailors
    Captain.where("id NOT IN (?)", self.sailors.pluck(:id))
  end

end




def self.talented_seafarers
  where("id IN (?) and id IN (?)", self.sailors.pluck(:id), self.motorists.pluck(:id))
end

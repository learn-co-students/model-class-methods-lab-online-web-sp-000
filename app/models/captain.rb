class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.select { |captain| captain.boats.any? { |boat| Boat.catamarans.include?(boat) } }
  end

  def self.sailors
    Captain.select { |captain| captain.boats.any? { |boat| Boat.sailboats.include?(boat) } }
  end

  def self.motorboat_operators
    Captain.select { |captain| captain.boats.any? { |boat| Boat.motorboats.include?(boat) } }
  end

  def self.talented_seafarers
    Captain.select do |captain|
      Captain.sailors.include?(captain) && Captain.motorboat_operators.include?(captain)
    end
  end

  def self.non_sailors
    Captain.select { |captain| !Captain.sailors.include?(captain) }
  end
end

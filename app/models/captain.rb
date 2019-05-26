class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    sailboat = Classification.find_by(name:"Sailboat")
    Captain.select do |captain|
      captain.boats.detect {|boat| boat.classifications.include?(sailboat)}
    end
  end

  def self.motorboaters
    motorboat = Classification.find_by(name:"Motorboat")
    Captain.select do |captain|
      captain.boats.detect {|boat| boat.classifications.include?(motorboat)}
    end
  end

  def self.talented_seafarers
    Captain.select do |captain|
      Captain.sailors.include?(captain) && Captain.motorboaters.include?(captain)
    end
  end

  def self.non_sailors
    Captain.select do |captain|
      !Captain.sailors.include?(captain)
    end
  end
end

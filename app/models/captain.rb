class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    catamaran_captain_ids = Boat.catamarans.map {|b| b.captain.id if b.captain}
    where(id: catamaran_captain_ids)
  end

  def self.sailors
    sailboat_captain_ids = Boat.sailboats.map {|b| b.captain.id if b.captain}
    where(id: sailboat_captain_ids)
  end

  def self.motorboat_operators
    motorboat_captain_ids = Boat.motorboats.map {|b| b.captain.id if b.captain}
    where(id: motorboat_captain_ids)
  end

  def self.talented_seafarers
    captains = sailors.concat(motorboat_operators).map {|c| c.id}
    talented_captain_ids = captains.find_all{|c| captains.count(c) > 1}.uniq
    where(id: talented_captain_ids)
  end

  def sailors_and_motorboat_operator_ids
    sailors.concat(motorboat_operators).map {|c| c.id}
  end

  def self.non_sailors
    not_sailors = self.all.map {|captain| captain.id if !sailors.include? captain}
    where(id: not_sailors)
  end
end

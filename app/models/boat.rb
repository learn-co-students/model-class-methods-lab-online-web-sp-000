class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  

  def self.first_five
    # all.limit(5)
    boats = self.all
    boats.limit(5).to_a
  end

  def self.dinghy
    # where("length < 20")
    boats = self.all
    boats.find_all.each do |boat|
      boat.length < 20
    end
  end

  def self.ship
    # where("length >= 20")
    boats = self.all
    boats.find_all.each do |boat|
      boat.length >= 20
    end
  end

  def self.last_three_alphabetically
    # all.order(name: :desc).limit(3)
    boats = self.all.order(name: :desc).limit(3)
    boats
  end

  def self.without_a_captain
    # where(captain_id: nil)
    boats = self.where(captain: nil)
    boats
  end

  def self.sailboats
    # includes(:classifications).where(classifications: { name: 'Sailboat' })
    boats = self.includes(:classifications).where(classifications: { name: 'Sailboat' })
    boats
  end

  def self.with_three_classifications
    # This is really complex! It's not common to write code like this
    # regularly. Just know that we can get this out of the database in
    # milliseconds whereas it would take whole seconds for Ruby to do the same.
    #
    # joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
    boats = self.joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
    boats
  end

  def self.non_sailboats
    # where("id NOT IN (?)", self.sailboats.pluck(:id))
    boats = self.where("id NOT IN (?)", self.sailboats.pluck(:id))
    boats
  end

  def self.longest
    # order('length DESC').first
    boats = self.order('length DESC').first
    boats
  end
end

class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    # binding.pry
    Boat.longest.classifications

    #  boat with the greatest length what is its classifications
    # binding.pry
  end

end

class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    # all
    self.all
  end

  
  def self.longest
    # Boat.longest.classifications

    max_length = self.includes(:boats).maximum("boats.length")
    self.includes(:boats).where("boats.length = ?", max_length)
  end

end

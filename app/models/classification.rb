class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.sailboats
    Classification.where(name: "Sailboat")
  end

end

class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    maximum_length = Boat.maximum('length')
    self.joins(:boats).where('boats.length = ?', maximum_length)
  end

end

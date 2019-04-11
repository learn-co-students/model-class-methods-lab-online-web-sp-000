class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
     @boats = Boat.limit(5)
  end

  def self.dinghy
    binding.pry
    @boats = Boat.where(length < 20)
  end

end

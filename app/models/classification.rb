class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    longest_boat = Boat.all.first
    Classification.all.each do |c|
      c.boats.each do |boat|
        if boat.length > longest_boat.length
          longest_boat = boat
        end
      end
    end
    longest_boat.classifications
  end

end

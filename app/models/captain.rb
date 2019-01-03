class Captain < ActiveRecord::Base
  has_many :boats

  def self._catamaran_operators  # => <Captain::ActiveRecord_Relation>

    # => Boats with class Catamaran. <Boat::ActiveRecord_Relation>
    catamarans = Boat.joins(:classifications)   
      .where("classifications.name=?","Catamaran")
    catamarans.map {|c| c.captain} # => Correct data, wrong type (array)

    captains_with_boats = Captain.joins(:boats) # => <Captain::ActiveRecord_Relation>
      .joins(:classifications) # empty Captain::ActiveRecord_Relation
      .where('classifications.name=?', 'Catamaran')

    # This doesn't work in Ruby but its generated SQL works in SQL. But, the generated SQL says nothing about classifications so never mind.
    captains_with_boats = Captain.joins(:boats).includes(:classifications)
    
    Captain.joins(:boats).includes(:classifications).where('classifications.name=?', 'Catamaran').references(:classifications)
  end

  def self.catamaran_operators  # => <Captain::ActiveRecord_Relation>
    # Captain.joins(:boat).where(boats: {classification_id: cat_class.id}) # empty
    
    # Captain.joins(:boat => :classification).where(boats: {classification: {id: cat_class.id}}) # empty
    
    Captain.includes(boats: :classifications).where(classifications: {name: "Catamaran"})

    cat_class = Classification.find_by(name: "Catamaran")
    c = Captain.joins("""
      INNER JOIN boats ON boats.captain_id = captains.id 
      INNER JOIN boat_classifications ON boats.id = boat_id 
      WHERE classification_id=#{cat_class.id}
      """)

  end

  def self.sailors
  end

  # returns captains of motorboats and sailboats
  def self.talented_seafarers 
  end
  
  # returns people who are not captains of sailboats
  def self.non_sailors
  end

end

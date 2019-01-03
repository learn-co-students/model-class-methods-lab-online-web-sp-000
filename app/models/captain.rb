class Captain < ActiveRecord::Base
  has_many :boats

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
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end

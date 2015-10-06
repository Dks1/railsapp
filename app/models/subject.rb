class Subject < ActiveRecord::Base
  
  has_many :pages
  
  # Don't need to validate (most of cases) :
  # id's, Foreign keys, timestamps, booleans, counters, 
  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  # validates_presence_of VS. validates_length_of :minimum => 1
  # Different error messages : "can't be blank" or "is too short"
  # validates_length_of allows string with only spaces!
  
  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("subjects.position ASC") }
  scope :newest_first, lambda { order("subjects.created_at DESC") }
  scope :search, lambda {|query|
    where(["name lIKE ?","%#{query}%"])
    }
    
end

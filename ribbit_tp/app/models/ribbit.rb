class Ribbit < ActiveRecord::Base

  default_scope order: 'createdat DESC' #The default_scope call is important; it orders a list of ribbits in from the most recent to least recent. 
  attr_accessible :content, :userid
  belongs_to :user    #The belongs_to method creates an association between this Ribbit class and the User class, making our user objects have a tweets array as a property.
 
  validates :content, length: { maximum: 140 }
end


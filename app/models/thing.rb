class Thing < ActiveRecord::Base

 	validates_presence_of :name,:category
 	validates :name, :length => { :maximum => 100 }
 	validates :category, :length => { :maximum => 100 }
end

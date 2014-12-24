# => SCHEMA
#
# => id 			: int (PRIMARY KEY)
# => name 			: varchar(255)
# => created_at		: datetime
# => updated_at		: datetime
# => user_id 		: int
#
class Artist < ActiveRecord::Base
	belongs_to :user

	def self.add(name, user_id)
		a = Artist.where(:user_id => user_id).where(:name => name).first
		if a.nil?
			a = Artist.new
			a.name = name
			a.user_id = user_id
			a.save
		end
		
		return a
	end
end

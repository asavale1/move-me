# => SCHEMA
#
# => id 			: int (PRIMARY KEY)
# => title			: varchar(255)
# => year			: varchar(255)
# => created_at		: datetimme
# => updated_at		: datetime
# => artist_id		: int
# => user_id 		: int
#

class Album < ActiveRecord::Base
	belongs_to :artist
	belongs_to :user

	def self.add(title, year, artist_id, user_id)

		a = Album.where(:user_id => user_id).where("artist_id = ? AND title = ? ", artist_id, title).first
		if a.nil?
			a = Album.new 
			a.title = title
			a.year = year
			a.artist_id = artist_id
			a.user_id = user_id
			a.save
		end
		
		return a
	end
end

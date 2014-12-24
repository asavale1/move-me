# => SCHEMA
#
# => id 			: int (PRIMARY KEY)
# => title			: varchar(255)
# => created_at		: datetime
# => updated_at		: datetime
# => album_id		: int
# => artist_id		: int
# => user_id 		: int
#
class Song < ActiveRecord::Base
	has_one :link
	belongs_to :album
	belongs_to :artist
	belongs_to :user

	def self.add(title, artist_id, album_id, user_id)
		s = Song.where(:user_id => user_id).where("artist_id = ? AND album_id = ? AND title = ?", artist_id, album_id, title).first
		if s.nil?
			s = Song.new
			s.title = title
			s.artist_id = artist_id
			s.album_id = album_id
			s.user_id = user_id
			s.save
		end
		
		return s
	end
end

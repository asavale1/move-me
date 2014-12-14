class Song < ActiveRecord::Base
	has_one :link
	belongs_to :album
	belongs_to :artist

	def self.add(title, artist_id, album_id)
		s = Song.where("artist_id = ? AND album_id = ? AND title = ?", artist_id, album_id, title).first
		if s.nil?
			s = Song.new
			s.title = title
			s.artist_id = artist_id
			s.album_id = album_id
			s.save
		end
		
		return s
	end
end

class Album < ActiveRecord::Base
	belongs_to :artist

	def self.add(title, year, artist_id)

		a = Album.where("artist_id = ? AND title = ? ", artist_id, title).first
		if a.nil?
			a = Album.new 
			a.title = title
			a.year = year
			a.artist_id = artist_id
			a.save
		end
		
		return a
	end
end

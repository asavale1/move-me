# => SCHEMA
#
# => id 			: int (PRIMARY KEY)
# => name			: varchar(255)
# => year			: varchar(255)
# => artist_id		: integer
# => created_at		: datetimme
# => updated_at		: datetime
#

class Album < ActiveRecord::Base
	has_many :songs
	belongs_to :artist
	has_and_belongs_to_many :playlists
	has_and_belongs_to_many :users

	def self.add(name, year, artist_id)
		a = Album.where(:artist_id => artist_id).where(:name => name).first
		if a.nil?
			a = Album.new
			a.name = name
			a.year = year
			a.artist_id = artist_id
			a.save
		end

		return a
	end
end

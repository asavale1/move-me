# => SCHEMA
#
# => id 			: int (PRIMARY KEY)
# => name			: varchar(255)
# => artist_id		: int
# => album_id		: int
# => created_at		: datetime
# => updated_at		: datetime
#
class Song < ActiveRecord::Base
	has_one :link
	belongs_to :album
	belongs_to :artist
	has_and_belongs_to_many :playlists
	has_and_belongs_to_many :users

	def self.add(name, album, artist, link)
		s = Song.where(:name => name).where(:artist_id => artist.id).where(:album_id  => album.id).first
		if s.nil?
			s = Song.new
			s.name = name
			s.album_id = album.id
			s.artist_id = artist.id
			s.link_id = link.id
			s.save
		end

		return s
	end
end

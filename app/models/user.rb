# => SCHEMA
#
# => id 			: int (PRIMARY KEY)
# => name			: varchar(255)
# => created_at		: datetime
# => updated_at		: datetime
# => username		: varchar(255)
#
class User < ActiveRecord::Base
	has_many :playlists, dependent: :destroy
	has_and_belongs_to_many :songs
	has_and_belongs_to_many :albums
	has_and_belongs_to_many :artists

	def self.add(name)
		
		u = User.where(:name => name).first
		if u.nil?
			u = User.new
			u.name = name
			u.username = name.gsub(' ','_').downcase
			u.save

			Playlist.add("library", u.id)
		end

		return u
	end
end

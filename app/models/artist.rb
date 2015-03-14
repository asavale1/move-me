# => SCHEMA
#
# => id 			: int (PRIMARY KEY)
# => name 			: varchar(255)
# => created_at		: datetime
# => updated_at		: datetime
#
class Artist < ActiveRecord::Base
	has_many :albums
	has_many :songs
	has_and_belongs_to_many :playlists
	has_and_belongs_to_many :users

	def self.add(name)
		a = Artist.where(name: name).first
		if a.nil?
			a = Artist.new
			a.name = name
			a.save
		end

		return a
	end
end

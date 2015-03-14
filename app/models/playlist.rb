# => SCHEMA
#
# => id 			: int (PRIMARY KEY)
# => name			: varchar(255)
# => user_id		: int
# => created_at		: datetime
# => updated_at		: datetime
# => username		: varchar(255)
#
class Playlist < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :songs
	has_and_belongs_to_many :albums
	has_and_belongs_to_many :artists

	def self.add(name, user_id)
		p = Playlist.where(:name => name).where(:user_id => user_id).first
		if p.nil?
			p = Playlist.new
			p.name = name
			p.user_id = user_id
			p.save

			unless File.directory?("#{@@parent_directory}/#{User.find(user_id).username}/#{name}")
				FileUtils.mkdir_p("#{@@parent_directory}/#{User.find(user_id).username}/#{name}")
			end
		end

		return p
	end
end

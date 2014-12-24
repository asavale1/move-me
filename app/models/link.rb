# => SCHEMA
#
# => id 			: int (PRIMARY KEY)
# => created_at		: datetime
# => updated_at		: datetime
# => path			: varchar(255)
# => song_id		: int
#
class Link < ActiveRecord::Base
	belongs_to :song

	def self.add(path, song_id)
		l = Link.where(:song_id => song_id).first
		if l.nil?
			l = Link.new
			l.path = path
			l.song_id = song_id
			l.save
		end
		
		return l
	end
end

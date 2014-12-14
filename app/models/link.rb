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

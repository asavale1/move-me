class Music < ActiveRecord::Base
	belongs_to :user

	def self.add(artist, album, name, location)
		if Music.where("artist =? AND album = ? AND name = ?", artist, album, name).length == 0
			music = Music.new
			music.name = name
			music.album = album
			music.artist = artist
			music.location = location
			music.save
		end
	end

end













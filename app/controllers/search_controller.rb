class SearchController < ApplicationController
	#include SearchHelper

	def get_albums_from_artist
		
	end

	def list_songs
		
	end

	def get_artists
		artists = Artist.all.map{ |a| {:id => a.id, :name => a.name} }
		render :json => artists.to_json

	end

	private
		def getAlbumsFromArtist(artist)
			albums = Set.new
			Song.where(:artist_id => artist.id).each{|song|
				albums.add(Album.find(song.album_id))
			}
			return albums
		end

		def getAlbumFromSong(song)
			Album.find(Song.find(song.id).album_id)
		end



end

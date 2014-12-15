class SearchController < ApplicationController
	
	def get_all_users
		users = User.all.map{ |u| {:id => u.id, :name => u.name } }
		render :json => users.to_json
	end

	def get_all_artists
		artists = Artist.all.map{ |a| {:id => a.id, :name => a.name} }
		render :json => artists.to_json
	end

	def get_all_albums
		albums = Album.all.map{ |a| {:id => a.id, :title => a.title } }
		render :json => albums.to_json
	end

	def get_album_by_artist
		album = Album.where(:artist_id => params[:artist_id]).map{ |a| {:id => a.id, :title => a.title} }
		render :json => album.to_json
	end

	def get_all_songs
		songs = Song.all.map{ |s| {:id => s.id, :title => s.title, :url => s.link.path} }
		render :json => songs.to_json
	end

	def get_songs_by_artist
		songs = Song.where(:artist_id => params[:artist_id]).map{ |s| {:id => s.id, :title => s.title, :url => s.link.path }}
		render :json => songs.to_json
	end

	def get_songs_by_album
		songs = Song.where(:album_id => params[:album_id]).map{ |s| {:id => s.id, :title => s.title, :url => s.link.path }}
		render :json => songs.to_json
	end

end

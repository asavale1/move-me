class SearchController < ApplicationController
	
	def get_users
		users = User.order("name").map{ |u| {:id => u.id, :name => u.name } }
		render :json => users.to_json
	end

	def get_playlists

		user = User.find(params[:user_id])
		playlists = user.playlists.order("name").map{ |p| {:id => p.id, :name => p.name}}

		render :json => playlists.to_json
	end

	def get_artists

		artists = []

		if params[:playlist_id].empty?
			user = User.find(params[:user_id])
			artists = user.artists.order("name").map{ |a| {:id => a.id, :name => a.name} }
		else
			playlist = Playlist.find(params[:playlist_id])
			artists = playlist.artists.order("name").map{ |a| {:id => a.id, :name => a.name} }
		end
		
		
		render :json => artists.to_json
	end

	def get_albums
		albums = []

		if params[:playlist_id].empty? and params[:artist_id].empty?
			user = User.find(params[:user_id])
			albums = user.albums.order("name").map{ |a| {:id => a.id, :name => a.name } }

		elsif params[:artist_id].empty? and !params[:playlist_id].empty?
			playlist = Playlist.find(params[:playlist_id])
			albums = playlist.albums.order("name").map{ |a| {:id => a.id, :name => a.name} }

		elsif !params[:artist_id].empty? and params[:playlist_id].empty?

			playlists = User.find(params[:user_id]).playlists
			playlists.each do |playlist|
				playlist.albums.order("name").each{ |album| 
					albums.push(album) if album.artist_id == params[:artist_id].to_i 						
				}
			end
			
			albums = albums.map{ |a| {:id => a.id, :name => a.name} }
		else
			playlist = Playlist.find(params[:playlist_id])
			playlist.albums.order("name").each{ |album|
				albums.push(album) if album.artist_id == params[:artist_id].to_i
			}

			albums = albums.map{ |a| {:id => a.id, :name => a.name} }
		end

		render :json => albums.to_json
	end

	def get_songs
		songs = []

		user_id = params[:user_id]
		playlist_id = params[:playlist_id]
		#artist_id = params[:artist_id]
		#album_id = params[:album_id]

		if playlist_id.empty?
			songs = User.find(params[:user_id]).songs.order("name").map{ |s|
				{ :id => s.id, :name => s.name, :link => Link.find(s.link_id).path.gsub("http://192.168.0.31", "http://192.168.0.15:3000") }
			}
		else
			songs = Playlist.find(params[:playlist_id]).songs.order("name").map{ |s|
				{ :id => s.id, :name => s.name, :link => Link.find(s.link_id).path.gsub("http://192.168.0.31", "http://192.168.0.15:3000") }
			}
		end
=begin
		if user_id.empty? and artist_id.empty? and album_id.empty?
			songs = Song.order("title").map{ |s| {:id => s.id, :title => s.title, :url => s.link.path} }
		elsif artist_id.empty? and album_id.empty?
			songs = User.find(user_id).songs.order("title").map{ |s| {:id => s.id, :title => s.title, :url => s.link.path} }
		elsif album_id.empty?
			songs = Song.where(:artist_id => artist_id).order("title").map{ |s| {:id => s.id, :title => s.title, :url => s.link.path} }
		else
			songs = Song.where(:album_id => album_id).order("title").map{ |s| {:id => s.id, :title => s.title, :url => s.link.path} }
		end
=end
		render :json => songs.to_json
	end

end

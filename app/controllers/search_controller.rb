class SearchController < ApplicationController
	
	def get_users
		users = User.all.map{ |u| {:id => u.id, :name => u.name } }
		render :json => users.to_json
	end

	def get_artists
		artists = nil
		if params[:user_id].empty?
			artists = Artist.all.map{ |a| {:id => a.id, :name => a.name} }
		else
			user = User.find(params[:user_id])
			artists = user.artists.map{ |a| {:id => a.id, :name => a.name} }
		end
		
		render :json => artists.to_json
	end

	def get_albums
		puts "\n\n"
		puts params
		puts "\n\n"
		albums = Album.all.map{ |a| {:id => a.id, :title => a.title } }
		render :json => albums.to_json
	end

	def get_songs
		songs = Song.all.map{ |s| {:id => s.id, :title => s.title, :url => s.link.path} }
		render :json => songs.to_json
	end

end

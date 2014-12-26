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
		albums = nil
		if params[:user_id].empty? and params[:artist_id].empty?
			puts "\n\nBOTH BLANK\n\n"
			albums = Album.all.map{ |a| {:id => a.id, :title => a.title } }
		elsif params[:artist_id].empty?
			puts "\n\nARTIST ID BLANK\n\n"
			user = User.find(params[:user_id])
			albums = user.albums.map{ |a| {:id => a.id, :title => a.title} }
		else
			puts "\n\nNONE BLANK\n\n"
			albums = Albums.where(:artist_d => params[:artist_id]).map{|a| {:id => a.id, :title => a.title}}
		end

		render :json => albums.to_json
	end

	def get_songs
		songs = Song.all.map{ |s| {:id => s.id, :title => s.title, :url => s.link.path} }
		render :json => songs.to_json
	end

end

class SearchController < ApplicationController
	
	def get_users
		users = User.order("name").map{ |u| {:id => u.id, :name => u.name } }
		render :json => users.to_json
	end

	def get_artists
		artists = nil
		if params[:user_id].empty?
			artists = Artist.order("name").map{ |a| {:id => a.id, :name => a.name} }
		else
			user = User.find(params[:user_id])
			artists = user.artists.order("name").map{ |a| {:id => a.id, :name => a.name} }
		end
		
		render :json => artists.to_json
	end

	def get_albums
		albums = nil
		if params[:user_id].empty? and params[:artist_id].empty?
			albums = Album.order("title").map{ |a| {:id => a.id, :title => a.title } }
		elsif params[:artist_id].empty?
			user = User.find(params[:user_id])
			albums = user.albums.order("title").map{ |a| {:id => a.id, :title => a.title} }
		else
			albums = Album.where(:artist_id => params[:artist_id]).order("title").map{|a| {:id => a.id, :title => a.title}}
		end

		render :json => albums.to_json
	end

	def get_songs
		songs = nil
		user_id = params[:user_id]
		artist_id = params[:artist_id]
		album_id = params[:album_id]
		if user_id.empty? and artist_id.empty? and album_id.empty?
			songs = Song.order("title").map{ |s| {:id => s.id, :title => s.title, :url => s.link.path} }
		elsif artist_id.empty? and album_id.empty?
			songs = User.find(user_id).songs.order("title").map{ |s| {:id => s.id, :title => s.title, :url => s.link.path} }
		elsif album_id.empty?
			songs = Song.where(:artist_id => artist_id).order("title").map{ |s| {:id => s.id, :title => s.title, :url => s.link.path} }
		else
			songs = Song.where(:album_id => album_id).order("title").map{ |s| {:id => s.id, :title => s.title, :url => s.link.path} }
		end
		
		render :json => songs.to_json
	end

end

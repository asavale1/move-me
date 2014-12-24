class DashboardController < ApplicationController
	before_filter :signed_in

	def home
		@user = User.find(session[:user_id])
		@albums = Album.uniq.pluck(:title)
	end

	def upload
		@user = User.find(session[:user_id])
		album = ( params[:album].strip.empty? ) ? "unknown" : params[:album].gsub(" ","_").downcase
		artist = ( params[:artist].strip.empty? ) ? "unknown" : params[:artist].gsub(" ", "_").downcase
		
		artist_obj = Artist.add(artist, @user.id)
		album_obj = Album.add(album, "2014", artist_obj.id, @user.id)	
		
		params[:files].each do |file|
			
			path = File.join(session[:audio_path], artist, album, file.original_filename)

			FileUtils.mkdir_p(File.dirname(path))
			File.open(path, "wb") { |f| f.write(file.read) }
			
			
			song_obj = Song.add(File.basename(path).split('.')[0], artist_obj.id, album_obj.id, @user.id)
			Link.add(File.join("http://192.168.0.31/links/#{@user.username}", artist, album, file.original_filename), song_obj.id)
		end

		redirect_to action: "home"
	end

	def user_select
		user_id = params[:user_id]
		artists = nil
		songs = nil
		albums = nil
		if user_id.empty?
			 artists = Artist.all
			 albums = Album.all
			 songs = Song.all
		else
			artists = User.find(user_id).artists
			albums = User.find(user_id).albums
			songs = User.find(user_id).songs 
		end

		render :json => {"artists"=> artists.to_json, "albums" => albums.to_json, "songs" => songs.to_json}
	end

	def artist_select
		artist_id = params[:artist_id]
		albums = nil
		songs = nil
		if artist_id.empty?
			albums = Album.all
			songs = Song.all
		else
			albums = Album.where(:artist_id => artist_id)
			songs = Song.where(:artist_id => artist_id)
		end
		
		render :json => { "albums" => albums.to_json,  "songs" => songs.to_json}
	end

	def album_select
		album_id = params[:album_id]
		songs = nil
		if album_id.empty?
			songs = Song.all
		else
			songs = Song.where(:album_id => params[:album_id])
		end
		
		render :json => songs.to_json
	end



	private
		def signed_in
			if session[:user_id].nil?
				redirect_to root_path
			end
		end

end

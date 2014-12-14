class DashboardController < ApplicationController
	before_filter :signed_in

	def home
		@user = User.find(session[:user_id])
		@albums = Album.uniq.pluck(:title)
	end

	def upload
		album = ( params[:album].strip.empty? ) ? "unknown" : params[:album].gsub(" ","_").downcase
		artist = ( params[:artist].strip.empty? ) ? "unknown" : params[:artist].gsub(" ", "_").downcase
		params[:files].each do |file|
			
			path = File.join(session[:audio_path], artist, album, file.original_filename)

			FileUtils.mkdir_p(File.dirname(path))
			File.open(path, "wb") { |f| f.write(file.read) }
			
			artist_obj = Artist.add(artist)
			album_obj = Album.add(album, "2014", artist_obj.id)
			song_obj = Song.add(File.basename(path), artist_obj.id, album_obj.id)
			Link.add(path, song_obj.id)
			
			
			
			#Music.add(artist, album, file.original_filename, path)

		end

		redirect_to action: "home"
	end

	private
		def signed_in
			if session[:user_id].nil?
				redirect_to root_path
			end
		end

end

class DashboardController < ApplicationController
	before_filter :signed_in

	def home
		@user = User.find(session[:user_id])
		@albums = Album.uniq.pluck(:name)
		@songs = Song.all.order("name")
		@playlists = Playlist.where("user_id = ?", @user.id)
	end

	def upload
		user = User.find(1)
		playlist = Playlist.where(:user_id => user.id).first

		if params[:files].length > 0
			album_name = ( params[:album].strip.empty? ) ? "unknown" : params[:album].strip.gsub(" ","_").downcase
			artist_name = ( params[:artist].strip.empty? ) ? "unknown" : params[:artist].strip.gsub(" ", "_").downcase

			artist = Artist.add(artist_name)
			playlist.artists << artist if playlist.artists.where(:id => artist.id).first.nil?
			user.artists << artist if user.artists.where(:id => artist.id).first.nil?

			album = Album.add(album_name, "2014", artist.id)
			playlist.albums << album if playlist.albums.where(:id => album.id).first.nil?
			user.albums << album if user.albums.where(:id => album.id).first.nil?

			params[:files].each do |file|
				
				path = File.join(@@library_directory, artist_name, album_name, file.original_filename)

				FileUtils.mkdir_p(File.dirname(path))
				File.open(path, "wb") { |f| f.write(file.read) }
				link = Link.add(File.join("http://192.168.0.31/links/vault/library", artist_name, album_name, file.original_filename))
				
				song = Song.add(File.basename(path).split('.mp3')[0], album, artist, link)
				
				playlist.songs << song if playlist.songs.where(:id => song.id).first.nil?

				user.songs << song if user.songs.where(:id => song.id).first.nil?

				playlist.save
				user.save
			end
		end

		redirect_to action: "home"
	end

	def playlist_add

		playlist = Playlist.find(params[:playlist])
		song = Song.find(params[:song])
		library = Playlist.where(:user_id => session[:user_id]).where(:name => "library").first		

		user_file_location = "#{@@parent_directory}/#{User.find(session[:user_id]).username}/#{playlist.name}/#{song.artist.name}/#{song.album.name}"
		user_library_location = "#{@@parent_directory}/#{User.find(session[:user_id]).username}/library/#{song.artist.name}/#{song.album.name}"
		vault_file_location = "#{@@parent_directory}/#{Link.find(song.link_id).path.gsub('http://192.168.0.31/links/','')}"

		if playlist.name != "library"
			playlist.songs << song if playlist.songs.where(:id => song.id).first.nil?
			playlist.save

			unless File.directory?(user_file_location)
				FileUtils.mkdir_p(user_file_location)
			end
			`ln -s #{vault_file_location} #{user_file_location}/`
		end
		

		library.songs << song if library.songs.where(:id => song.id).first.nil?
		library.save

		unless File.directory?(user_library_location)
			FileUtils.mkdir_p(user_library_location)
		end
		
		`ln -s #{vault_file_location} #{user_library_location}`

		redirect_to action: "home"
	end

	def playlist_create
		playlist = params[:name].strip
		unless playlist.empty?
			playlist = playlist.gsub(" ", "_").downcase
			user = User.find(session[:user_id])
			Playlist.add(playlist, user.id)
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

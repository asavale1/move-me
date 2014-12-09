class DashboardController < ApplicationController
	before_filter :signed_in

	def home
		@user = User.find(session[:user_id])
		@albums = Music.uniq.pluck(:album)
	end

	def upload
		album = ( params[:album].strip.empty? ) ? "unknown" : params[:album].gsub(" ","_").downcase
		artist = ( params[:artist].strip.empty? ) ? "unknown" : params[:artist].gsub(" ", "_").downcase
		params[:files].each do |file|
			
			path = File.join(session[:audio_path], album, artist, file.original_filename)

			FileUtils.mkdir_p(File.dirname(path))
			File.open(path, "wb") { |f| f.write(file.read) }
			Music.add(artist, album, file.original_filename, path)

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

require "#{Rails.root}/lib/custom/util.rb"

class RootController < ApplicationController

	def home
		User.add("vault")
	end

	def add_user
		user = User.add(params[:name].strip)

		unless File.directory?("#{@@parent_directory}/#{user.username}")
			Dir.mkdir("#{@@parent_directory}/#{user.username}")
		end

		redirect_to action: "home"
	end

	def select_user
		session[:user_id] = params[:user]
		session[:audio_path] = "#{@@parent_directory}/#{User.find(params[:user]).username}"
		redirect_to controller: "dashboard", action: "home"
	end

end

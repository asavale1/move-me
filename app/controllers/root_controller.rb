require "#{Rails.root}/lib/custom/util.rb"

class RootController < ApplicationController

	def home
	end

	def add_user
		user = User.new
		user.name = params[:name]
		user.username = params[:name].gsub(' ','_').downcase
		user.save
		
		Dir.mkdir("#{@@parent_directory}/#{user.username}")

		redirect_to action: "home"
	end

	def select_user
		session[:user_id] = params[:user]
		session[:audio_path] = "#{@@parent_directory}/#{User.find(params[:user]).username}"
		redirect_to controller: "dashboard", action: "home"
	end

end

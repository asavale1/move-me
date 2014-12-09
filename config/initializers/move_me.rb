if Rails.env == "production"
	@@parent_directory = "/home/ameya/music/move-me"
else 
	@@parent_directory = "#{Rails.root}/test/music"
end

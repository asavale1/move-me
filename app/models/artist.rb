class Artist < ActiveRecord::Base
	def self.add(name)
		a = Artist.where(:name => name).first
		if a.nil?
			a = Artist.new
			a.name = name
			a.save
		end
		
		return a
	end
end

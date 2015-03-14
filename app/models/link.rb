# => SCHEMA
#
# => id 			: int (PRIMARY KEY)
# => created_at		: datetime
# => updated_at		: datetime
# => path			: varchar(255)
#
class Link < ActiveRecord::Base
	belongs_to :song

	def self.add(path)
		l = Link.where(:path => path).first
		if l.nil?
			l = Link.new
			l.path = path
			l.save
		end
		
		return l
	end
end

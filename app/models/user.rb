# => SCHEMA
#
# => id 			: int (PRIMARY KEY)
# => name			: varchar(255)
# => created_at		: datetime
# => updated_at		: datetime
# => username		: varchar(255)
#
class User < ActiveRecord::Base
	has_many :songs
	has_many :albums
	has_many :artists
end

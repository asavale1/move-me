class CreateArtistsUsers < ActiveRecord::Migration
  def self.up
		create_table :artists_users, :id => false do |t|
			t.references :user
			t.references :artist
		end
		add_index :artists_users, [:user_id, :artist_id]
		add_index :artists_users, :artist_id
	end

  	def self.down
		drop_table :artists_users
	end
end



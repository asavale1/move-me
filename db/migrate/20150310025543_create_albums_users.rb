class CreateAlbumsUsers < ActiveRecord::Migration
  def self.up
		create_table :albums_users, :id => false do |t|
			t.references :user
			t.references :album
		end
		add_index :albums_users, [:user_id, :album_id]
		add_index :albums_users, :album_id
	end

  	def self.down
		drop_table :albums_users
	end
end



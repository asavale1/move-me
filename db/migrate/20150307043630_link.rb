class Link < ActiveRecord::Migration
  def change
  	create_table :links do |t|
		t.string "path"
		t.timestamps
    end
  end
end

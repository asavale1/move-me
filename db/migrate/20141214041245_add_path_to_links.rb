class AddPathToLinks < ActiveRecord::Migration
  def change
    add_column :links, :path, :string
  end
end

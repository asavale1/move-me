class AddAlbumToMusics < ActiveRecord::Migration
  def change
    add_column :musics, :album, :string
  end
end

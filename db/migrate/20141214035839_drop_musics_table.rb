class DropMusicsTable < ActiveRecord::Migration
   def up
    drop_table :musics
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

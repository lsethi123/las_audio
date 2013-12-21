class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :name
      t.integer :size
      t.string :audio

      t.timestamps
    end
  end
end

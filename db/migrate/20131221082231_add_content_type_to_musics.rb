class AddContentTypeToMusics < ActiveRecord::Migration
  def change
    add_column :musics, :content_type, :string
  end
end

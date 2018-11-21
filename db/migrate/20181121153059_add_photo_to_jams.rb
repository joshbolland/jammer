class AddPhotoToJams < ActiveRecord::Migration[5.2]
  def change
    add_column :jams, :photo, :string
  end
end

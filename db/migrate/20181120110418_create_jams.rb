class CreateJams < ActiveRecord::Migration[5.2]
  def change
    create_table :jams do |t|
      t.string :title
      t.date :date
      t.time :time
      t.string :location
      t.float :lat
      t.float :lng
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

class CreateSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :slots do |t|
      t.references :user, foreign_key: true
      t.references :jam, foreign_key: true
      t.references :instrument, foreign_key: true

      t.timestamps
    end
  end
end

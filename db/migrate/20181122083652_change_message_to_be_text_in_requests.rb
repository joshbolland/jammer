class ChangeMessageToBeTextInRequests < ActiveRecord::Migration[5.2]
  def change
    change_column :requests, :message, :text
  end
end

class RemoveAbilityFromUserInstruments < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_instruments, :ability, :string
  end
end

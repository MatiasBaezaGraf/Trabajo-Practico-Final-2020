class AddUsernamelToReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :usernamel, :string
  end
end

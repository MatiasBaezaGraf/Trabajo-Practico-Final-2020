class AddUsernamefToReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :usernamef, :string
  end
end

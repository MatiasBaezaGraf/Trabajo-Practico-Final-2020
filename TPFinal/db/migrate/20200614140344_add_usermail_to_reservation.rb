class AddUsermailToReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :usermail, :string
  end
end

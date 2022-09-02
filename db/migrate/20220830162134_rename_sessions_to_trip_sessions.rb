class RenameSessionsToTripSessions < ActiveRecord::Migration[7.0]
  def change
    rename_table :sessions, :trip_sessions
  end
end

class RenameReferencesToSessionsToTripSessions < ActiveRecord::Migration[7.0]
  def change
    rename_column :requests, :session_id, :trip_session_id
    rename_column :game_matches, :session_id, :trip_session_id
    rename_column :messages, :session_id, :trip_session_id
  end
end

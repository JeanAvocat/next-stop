class Changereferencesjoiner < ActiveRecord::Migration[7.0]
  def change
    change_column_null :trip_sessions, :joiner_id, true
  end
end

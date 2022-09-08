class Changemodelchifoumi < ActiveRecord::Migration[7.0]
  def change
    change_column_null :chifoumi_games, :first_player_id, true
    change_column_null :chifoumi_games, :second_player_id, true
  end
end

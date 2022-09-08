class Changereferencestictactoe < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tic_tac_toe_games, :cross_player_id, true
    change_column_null :tic_tac_toe_games, :circle_player_id, true
  end
end

class AddDefaultValueToChifoumiGame < ActiveRecord::Migration[7.0]
  def change
    change_column :chifoumi_games, :first_player_score, :integer, default: 0
    change_column :chifoumi_games, :second_player_score, :integer, default: 0
    change_column :chifoumi_games, :play_round, :integer, default: 0
  end
end

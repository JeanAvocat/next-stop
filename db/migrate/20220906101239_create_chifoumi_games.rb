class CreateChifoumiGames < ActiveRecord::Migration[7.0]
  def change
    create_table :chifoumi_games do |t|
      t.string :first_player_choice
      t.string :second_player_choice
      t.integer :play_round
      t.integer :first_player_score
      t.integer :second_player_score
      t.references :first_player, null: false, foreign_key: {to_table: :users}
      t.references :second_player, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end

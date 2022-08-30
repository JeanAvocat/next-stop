class CreateTicTacToeGames < ActiveRecord::Migration[7.0]
  def change
    create_table :tic_tac_toe_games do |t|
      t.string :position_1
      t.string :position_2
      t.string :position_3
      t.string :position_4
      t.string :position_5
      t.string :position_6
      t.string :position_7
      t.string :position_8
      t.string :position_9
      t.references :cross_player, null: false, foreign_key: {to_table: :users}
      t.references :circle_player, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end

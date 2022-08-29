class TicTacToeGame < ApplicationRecord
  belongs_to :cross_player, class_name: "User"
  belongs_to :circle_player, class_name: "User"
  has_many :game_matches, as: :matchable
end

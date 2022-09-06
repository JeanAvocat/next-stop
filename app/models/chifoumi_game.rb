class ChifoumiGame < ApplicationRecord
  belongs_to :first_player, foreign_key: :first_player_id, class_name: "User"
  belongs_to :second_player, foreign_key: :second_player_id, class_name: "User"
  has_many :game_matches, as: :matchable
end

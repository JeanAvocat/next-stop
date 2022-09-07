class ChifoumiGame < ApplicationRecord
  belongs_to :first_player, foreign_key: :first_player_id, class_name: "User"
  belongs_to :second_player, foreign_key: :second_player_id, class_name: "User"
  has_many :game_matches, as: :matchable

  def end_of_a_game?
  # anounce that game is finish if there is a winner or if all tile are write
  # announce there is a winner if a winning pattern has all the same symbol
  # check if there is a winner only if at least 5 tiles are selected
  return if play_round >= 4
  # return true if there is a winning pattern
  final_winning_patern?
  end

  def result
    # should return the result of the game: Name of the winnner
    case final_winning_patern?
    when "first_player" then "Le gagnant est #{first_player.random_nickname}"
    when "second_player" then "Le gagnant est #{second_player.random_nickname}"
    end
  end

  def round_patern?
    # should return true if a winning combination is present
    
    winning_combinations = ["rock" > "scissors", "scissors" > "paper", "paper" > "rock"]
  end

  def final_winning_patern?
    # should return true if there is a final winner
    (first_player_score - second_player_score).abs >= 2 && (first_player_score >= 3 || second_player_score >= 3)
  end
end

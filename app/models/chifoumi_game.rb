class ChifoumiGame < ApplicationRecord
  belongs_to :first_player, foreign_key: :first_player_id, class_name: "User"
  belongs_to :second_player, foreign_key: :second_player_id, class_name: "User"
  has_many :game_matches, as: :matchable

  def who_have_to_play
    play_round.even? ? first_player : second_player
  end

  def end_of_a_game?
    return if play_round <= 4

    # return true if there is a winner
    first_player_score >= 3 || second_player_score >= 3
  end

  def result
    return unless end_of_a_game?

    # should return the result of the game: Name of the winnner
    first_player_score > second_player_score ? first_player.random_nickname : second_player.random_nickname
    # case final_winner?
    # when "first_player" then "Le gagnant est #{first_player.random_nickname}"
    # when "second_player" then "Le gagnant est #{second_player.random_nickname}"
    # when "draw" then "Pas de gagnant, le match continue !"
    # end
  end

  def round_winner
    return "égalité" if winning_pattern == "tie"

    first_player_choice == winning_pattern ? first_player.random_nickname : second_player.random_nickname
  end

  def round_pattern
    [first_player_choice, second_player_choice].sort
  end

  def winning_pattern
    # ["paper", "rock"]  => "paper"
    # ["rock", "scissor"] => "rock"
    # ["paper", "scissor"] => "scissor"
    case round_pattern
    when ["paper", "rock"] then "paper"
    when ["rock", "scissors"] then "rock"
    when ["paper", "scissors"] then "scissors"
    else "tie"
    end
  end

  def winner?
    # should return true if there is a final winner
    # (first_player_score - second_player_score).abs >= 2 &&
    first_player_score >= 3 || second_player_score >= 3
  end
end

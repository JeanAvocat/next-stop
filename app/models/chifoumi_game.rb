class ChifoumiGame < ApplicationRecord
  belongs_to :first_player, foreign_key: :first_player_id, class_name: "User"
  belongs_to :second_player, foreign_key: :second_player_id, class_name: "User"
  has_many :game_matches, as: :matchable

  def who_can_play(current_user)
    player = which_player(current_user)
    public_send("#{player}_choice") == "next-round"
  end

  def play_round_zero?
    play_round.zero?
  end

  def which_player(current_user)
    first_player == current_user ? "first_player" : "second_player"
  end

  def which_competitor(current_user)
    first_player == current_user ? "second_player" : "first_player"
  end

  def start_round?
    [first_player_choice, second_player_choice].uniq.join == "next-round"
  end

  def end_of_a_round?
    play_round.even? && [first_player_choice, second_player_choice].uniq.join != "next-round"
  end

  def display_score
    "#{first_player.random_nickname} à #{first_player_score} points et #{second_player.random_nickname} à #{second_player_score} points"
  end

  def end_of_a_game?
    return if play_round <= 4

    # return true if there is a winner
    winner?
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
    if first_player_choice == winning_pattern
      "#{first_player.random_nickname} à gagné cette manche"
    elsif second_player_choice == winning_pattern
      "#{second_player.random_nickname} à gagné cette manche"
    else
      "égalité"
    end
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
    two_points_difference = (first_player_score - second_player_score).abs >= 2
    minimal_score = first_player_score >= 3 || second_player_score >= 3
    minimal_score && two_points_difference
  end
end

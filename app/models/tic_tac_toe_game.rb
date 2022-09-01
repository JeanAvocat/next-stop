class TicTacToeGame < ApplicationRecord
  belongs_to :cross_player, foreign_key: :cross_player_id, class_name: "User"
  belongs_to :circle_player, foreign_key: :circle_player_id, class_name: "User"
  has_many :game_matches, as: :matchable

  def end_of_a_game?
    # anounce that game is finish if there is a winner or if all tile are write
    # announce there is a winner if a winning pattern has all the same symbol
    # check if there is a winner only if at least 5 tiles are selected
    return if nil_position >= 5

    # call method result if there is a winning pattern or if nil position is 0
    winning_patern? || nil_position.zero?
  end

  def result
    # should return the result of the game: Name of the winnner or draw
    case select_winner.flatten.uniq.join
    when "X" then cross_player.first_name
    when "O" then circle_player.first_name
    else "Draw"
    end
  end

  private

  def nil_position
    # method to check if there is still a nill position
    nil_position = (1..9).map do |n|
      send("position_#{n}")
    end

    nil_position.select(&:nil?).size
  end

  def winning_patern?
    # should return true if a winning pattern are all the same symbol
    # 1| 2 | 3
    # 4| 5 | 6
    # 7| 8 | 9
    select_winner.flatten.any?
  end

  def select_winner
    # select the winner combination
    game_pattern.select do |winning_pattern|
      winning_pattern.uniq.size == 1
    end
  end

  def game_pattern
    # Winning_patterns is an array with winning combination of tic tac toe
    # 1| 2 | 3
    # 4| 5 | 6
    # 7| 8 | 9
    winning_patterns = [[1, 2, 3], [1, 4, 7], [1, 5, 9], [2, 5, 8], [3, 5, 7], [3, 6, 9], [4, 5, 6], [7, 8, 9]]

    # I return an array with the pattern of the current game
    winning_patterns.map do |winning_pattern|
      winning_pattern.map do |n|
        send("position_#{n}")
      end
    end
  end
end

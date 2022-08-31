class TicTacToeGame < ApplicationRecord
  belongs_to :cross_player, class_name: "User"
  belongs_to :circle_player, class_name: "User"
  has_many :game_matches, as: :matchable

  def end_of_a_game?
    # anounce that game is finish if there is a winner or if all tile are write
    # announce there is a winner if a winning pattern has all the same symbol
    winning_patern?
  end

  def result
    # should return the result of the game: Name of the winnner or draw

    # if select_winner.flatten.uniq.join == "X"
    #   cross_player.first_name
    # elsif select_winner.flatten.uniq.join == "O"
    #   circle_player.first_name
    # else
    #   "draw"
    # end

    case select_winner.flatten.uniq.join
    when "X" then cross_player.first_name
    when "O" then circle_player.first_name
    else "Draw"
    end
  end

  private

  def winning_patern?
    # should return true if a winning pattern are all the same symbol
    # winning_pattern = "1.2.3"
    # winning_pattern = "1.4.7"
    # winning_pattern = "1.5.9"
    # winning_pattern = "2.5.8"
    # winning_pattern = "3.5.7"
    # winning_pattern = "3.6.9"
    # winning_pattern = "4.5.6"
    # winning_pattern = "7.8.9"
    select_winner.flatten.any?
  end

  def select_winner
    game_pattern.select do |winning_pattern|
      winning_pattern.uniq.size == 1
    end
  end

  def game_pattern
    # Winning_patterns is an array with winning combination of tic tac toe
    winning_patterns = [[1, 2, 3], [1, 4, 7], [1, 5, 9], [2, 5, 8], [3, 5, 7], [3, 6, 9], [4, 5, 6], [7, 8, 9]]

    # I return an array with the pattern of the current game
    winning_patterns.map do |winning_pattern|
      winning_pattern.map do |n|
        send("position_#{n}")
      end
    end
  end
end

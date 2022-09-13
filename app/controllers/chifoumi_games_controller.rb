class ChifoumiGamesController < ApplicationController
  def select_weapon
    # catch id of game_match url
    @game_match = GameMatch.find(params[:id])
    # create instance Tic tac toe about the game match
    @chifoumi_game = @game_match.matchable
    if params[:play] == "next-round"
      @chifoumi_game.update(first_player_choice: params[:play], second_player_choice: params[:play])
      broadcast_next_round
    end

    return unless @chifoumi_game.who_can_play(current_user) && params[:choice]

    if current_user == @chifoumi_game.first_player
      @chifoumi_game.update(first_player_choice: params[:choice])
    else
      @chifoumi_game.update(second_player_choice: params[:choice])
    end
    update_play_round
    update_score
    @game_match.update(winner: @chifoumi_game.result.split.last) if @chifoumi_game.end_of_a_game?
    broadcast_sign if params[:play] != "next-round"
  end

  private

  def other_player_choice
    current_user == @chifoumi_game.first_player ? @chifoumi_game.second_player_choice : @chifoumi_game.first_player_choice
  end

  def broadcast_next_round
    ChifoumiGameChannel.broadcast_to(
      @game_match,
      next: params[:play],
      play_round: @chifoumi_game.play_round,
      player: current_user.id
    )
  end

  def broadcast_sign
    ChifoumiGameChannel.broadcast_to(
      @game_match,
      choice: params[:choice],
      other_choice: other_player_choice,
      player: current_user.id,
      play_round: @chifoumi_game.play_round,
      winner: @chifoumi_game.round_winner,
      score: @chifoumi_game.display_score,
      result: @chifoumi_game.result
    )
  end

  def update_play_round
    @chifoumi_game.update(play_round: @chifoumi_game.play_round + 1)
  end

  def update_score
    return unless @chifoumi_game.play_round.even? && @chifoumi_game.play_round.positive?

    if @chifoumi_game.first_player_choice == @chifoumi_game.winning_pattern
      @chifoumi_game.update(first_player_score: @chifoumi_game.first_player_score + 1)
    elsif @chifoumi_game.second_player_choice == @chifoumi_game.winning_pattern
      @chifoumi_game.update(second_player_score: @chifoumi_game.second_player_score + 1)
    end
  end
end

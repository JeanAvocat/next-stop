class TicTacToeGamesController < ApplicationController
  def select_tile
    # catch id of game_match url
    @game_match = GameMatch.find(params[:id])
    # find the trip session of the game match
    @trip_session = @game_match.trip_session
    # create instance Tic tac toe about the game match
    @tic_tac_toe_game = @game_match.matchable
    # broadcast the tic_tac_toe_game_channel to send new information about tic tac toe
    broadcast if update_tile
    # update the result of game match if end of the game method is true
    if @tic_tac_toe_game.end_of_a_game?
      @game_match.winner = @tic_tac_toe_game.result.split.last
      @game_match.save
    end
    # update the score of players (only if we have a winner)
    add_score unless @game_match.winner.nil?
  end

  private

  def update_tile
    # stop the action if end of game
    return if @tic_tac_toe_game.end_of_a_game?

    # methode to define who can play, update of the tic tac toe table only if it is to the current player to play
    if [@tic_tac_toe_game.cross_player, @tic_tac_toe_game.who_have_to_play, current_user].uniq.count == 1
      @tic_tac_toe_game.update("position_#{params[:tile]}": "cross")
    elsif [@tic_tac_toe_game.circle_player, @tic_tac_toe_game.who_have_to_play, current_user].uniq.count == 1
      @tic_tac_toe_game.update("position_#{params[:tile]}": "circle")
    end
  end

  def broadcast
    # send data to the game match view
    TicTacToeGameChannel.broadcast_to(
      @game_match,
      render_to_string(partial: "tic_tac_toe_games/selected_tile", locals: { tic_tac_toe_game: @tic_tac_toe_game, n: params[:tile] })
    )
    head :ok
  end

  def add_score
    # creator win 3 points
    if @game_match.winner == @trip_session.creator.random_nickname
      @trip_session.creator.score += 3
    # joiner win 3 points
    elsif @game_match.winner == @trip_session.joiner.random_nickname
      @trip_session.joiner.score += 3
    # draw 1 point for both
    elsif @game_match.winner == "égalité"
      @trip_session.creator.score += 1
      @trip_session.joiner.score += 1
    end
    # save points in the user database
    @trip_session.creator.save
    @trip_session.joiner.save
  end
end

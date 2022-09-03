class TicTacToeGamesController < ApplicationController
  def select_tile
    @game_match = GameMatch.find(params[:id])
    @tic_tac_toe_game = @game_match.matchable
    if @tic_tac_toe_game.cross_player == current_user
      @tic_tac_toe_game.update("position_#{params[:tile]}": "cross")
    else
      @tic_tac_toe_game.update("position_#{params[:tile]}": "circle")
    end

    @tic_tac_toe_game.who_have_to_play

    TicTacToeGameChannel.broadcast_to(
      @game_match,
      render_to_string(partial: "tic_tac_toe_games/tic_tac_toe_game", locals: { tic_tac_toe_game: @tic_tac_toe_game })
    )
    head :ok
  end
end

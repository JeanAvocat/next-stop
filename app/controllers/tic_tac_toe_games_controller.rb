class TicTacToeGamesController < ApplicationController
  def select_tile
    @game_match = GameMatch.find(params[:id])
    @tic_tac_toe_game = @game_match.matchable
    if @tic_tac_toe_game.cross_player == current_user
      @tic_tac_toe_game.update("position_#{params[:tile]}": "cross")
    else
      @tic_tac_toe_game.update("position_#{params[:tile]}": "circle")
    end

    @tic_tac_toe_game.end_of_a_game?
    redirect_to game_match_path
  end
end

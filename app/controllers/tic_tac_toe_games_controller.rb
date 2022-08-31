class TicTacToeGamesController < ApplicationController
  def select_tile
    @game_match = GameMatch.find(params[:id])
    @tic_tac_toe_game = @game_match.matchable
    if @tic_tac_toe_game.cross_player == current_user
      @tic_tac_toe_game.update("#{params[:tile]}": "X")
    else
      @tic_tac_toe_game.update("#{params[:tile]}": "O")
    end

    redirect_to game_match_path
  end

  private

  def tic_tac_toe_game_params
    params.require(:tile).permit(:tile)
  end
end

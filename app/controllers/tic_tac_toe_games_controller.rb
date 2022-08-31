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

end

# winning_pattern = "1.2.3"
# winning_pattern = "1.4.7"
# winning_pattern = "1.5.9"
# winning_pattern = "2.5.8"
# winning_pattern = "3.5.7"
# winning_pattern = "3.6.9"
# winning_pattern = "4.5.6"
# winning_pattern = "7.8.9"

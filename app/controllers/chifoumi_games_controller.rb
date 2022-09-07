class ChifoumiGamesController < ApplicationController

  def select_weapon
    # catch id of game_match url
    @game_match = GameMatch.find(params[:id])
    # create instance Tic tac toe about the game match
    @chifoumi_game = @game_match.matchable
    if current_user == @chifoumi_game.first_player
      @chifoumi_game.update(first_player_choice: params[:first_player_choice])
    else
      @chifoumi_game.update(second_player_choice: params[:second_player_choice])
    end
    # update the result of game match if end of the game method is true
    @game_match.update(winner: @chifoumi_game.result.split.last) if @chifoumi_game.end_of_a_game?
  end
end

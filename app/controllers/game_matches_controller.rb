class GameMatchesController < ApplicationController
  def show
    @game_match = GameMatch.find(params[:id])
    @tic_tac_toe_game = @game_match.matchable
  end
end

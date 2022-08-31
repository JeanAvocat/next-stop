class GameMatchesController < ApplicationController
  def counter
    @counter = 5
    @game_match = GameMatch.find(params[:id])
  end
end

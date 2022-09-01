class GameMatchesController < ApplicationController
  def show
    @game_match = GameMatch.find(params[:id])
    @tic_tac_toe_game = @game_match.matchable

    # Chatroom
    @trip_session = @game_match.trip_session
    @message = Message.new
  end

  def counter
  end
end

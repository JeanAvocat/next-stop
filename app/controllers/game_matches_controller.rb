class GameMatchesController < ApplicationController
  def show
    @game_match = GameMatch.find(params[:id])
    @tic_tac_toe_game = @game_match.matchable

    # Chatroom
    @trip_session = @game_match.trip_session
    @message = Message.new
    @buddy = current_user.id == @trip_session.creator_id ? @trip_session.joiner_id : @trip_session.creator_id
    @buddy = User.find(@buddy).random_nickname
  end

  def counter
    @counter = 5
    @game_match = GameMatch.find(params[:id])
  end
end

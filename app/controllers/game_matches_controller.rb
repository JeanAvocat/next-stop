class GameMatchesController < ApplicationController
  before_action :set_game_match, only: %i[show counter return]
  def show
    @tic_tac_toe_game = @game_match.matchable
    # Chatroom
    @trip_session = @game_match.trip_session
    @message = Message.new
    @buddy = current_user.id == @trip_session.creator_id ? @trip_session.joiner_id : @trip_session.creator_id
    @buddy = User.find(@buddy).random_nickname
  end

  def counter
    @counter = 5
    @trip_session = @game_match.trip_session
  end

  def return
    @trip_session = @game_match.trip_session
    @trip_session.status = "closed"
    ReturnGameMatchChannel.broadcast_to(
      @game_match,
      " "
    )
    redirect_to new_trip_session_path, status: :see_other
  end

  private

  def set_game_match
    @game_match = GameMatch.find(params[:id])
  end
end

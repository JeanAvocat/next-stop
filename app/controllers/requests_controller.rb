class RequestsController < ApplicationController
  def create
    @trip_session = TripSession.find(params[:trip_session_id])
    @game_match = @trip_session.game_matches.last
    @request = Request.new
    @request.trip_session_id = @trip_session.id
    @request.sender_id = current_user.id
    @request.status = "pending"
    if @request.save
      redirect_to game_match_path(@game_match)
    end
  end

  def accept
    @trip_session = TripSession.find(params[:trip_session_id])
    @game_match = @trip_session.game_matches.last
    @request_accepted = @trip_session.request.last
    @request_accepted.status = "accepted"
    if @request_accepted.save
      redirect_to game_match_path(@game_match)
    end
  end

  def decline
    @trip_session = TripSession.find(params[:trip_session_id])
    @game_match = @trip_session.game_matches.last
    @request_declined = @trip_session.request.last
    @request_declined.status = "refused"
    if @request_declined.save
      redirect_to game_match_path(@game_match)
    end
  end
end

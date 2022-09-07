class RequestsController < ApplicationController
  def create
    @trip_session = TripSession.find(params[:trip_session_id])
    @game_match = @trip_session.game_matches.last
    @request = Request.new
    @request.trip_session_id = @trip_session.id
    @request.sender_id = current_user.id
    @request.status = "pending"
    if @request.save
      # redirect_to game_match_path(@game_match)
      RequestChannel.broadcast_to(
        @game_match,
        current_user.id
      )
      head :ok
    else
    end
  end

  def accept
    update_request_status
    @request_answer.status = "accepted"
    @request_answer.save
    RequestChannel.broadcast_to(
      @game_match,
      "reveal"
    )
    redirect_to game_match_reveal_profil_path(@game_match), status: :see_other
  end

  def decline
    update_request_status
    @request_answer.status = "refused"
    if @request_answer.save
      # redirect_to game_match_path(@game_match)
    end
  end

  def update_request_status
    @game_match = GameMatch.find(params[:id])
    @trip_session = @game_match.trip_session_id
    @trip_session = TripSession.find(@trip_session)
    @request_answer = @trip_session.requests.last
  end
end

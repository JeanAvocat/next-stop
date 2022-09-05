class GameMatchesController < ApplicationController
  def show
    @game_match = GameMatch.find(params[:id])
    @tic_tac_toe_game = @game_match.matchable

    # Chatroom
    @trip_session = @game_match.trip_session
    @message = Message.new
    @buddy = current_user.id == @trip_session.creator_id ? @trip_session.joiner_id : @trip_session.creator_id
    @buddy = User.find(@buddy).random_nickname

    # Requests
    @request = Request.new
    @lastrequest = @trip_session.requests.exists? ? @trip_session.requests.last.status : nil
    classForSendRequest
    classFotAnswerRequest
  end

  def counter
    @counter = 5
    @game_match = GameMatch.find(params[:id])
  end

  private

  def classForSendRequest
    @requestclass = @lastrequest == nil ? "" : "d-none"
  end

  def classFotAnswerRequest
    if @lastrequest == nil || @lastrequest == "refused"
      # There were no request yet, or the request has been refused
      @answerrequestclass = "d-none"
    elsif @lastrequest == "pending" && current_user.id == @trip_session.requests.last.sender_id
      # There is a pending request, sent by the current user
      @answerrequestclass = "d-none"
    elsif @lastrequest == "pending" && current_user.id != @trip_session.requests.last.sender_id
      # There is a pending request, sent by the buddy
      @answerrequestclass = ""
    elsif @lastrequest == "accepted"
      # There was a request that was accepted
      @answerrequestclass = "d-none"
    end
  end
end

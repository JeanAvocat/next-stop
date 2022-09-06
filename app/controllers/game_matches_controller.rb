class GameMatchesController < ApplicationController
  before_action :set_game_match, only: %i[show counter return]
  def show
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

  def create
    # find the previous game match of both players together before to save the next one
    @previous_game_match = find_last_trip_sessions.game_matches.last
    # create the new tic tac toe game
    tic_tac_toe_game = tic_tac_toe_creation
    # creation of new instance of game_match and tic tac toe game
    @game_match = GameMatch.new
    # find the last trip_sessions from the last trip_sessions of current user
    @game_match.trip_session = find_last_trip_sessions
    # add the tic tac toe game id to the game match
    @game_match.matchable = tic_tac_toe_game
    # save the new game_match instance in DB
    @game_match.save
    # send info to other player to restart the game
    broadcast_previous_game_match
    # redirect to game_match show
    redirect_to game_match_path(@game_match)
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

  def find_last_trip_sessions
    # define last trip_sessions_as_creator
    creator_id = current_user.trip_sessions_as_creator.last.id
    # define last trip_sessions_as_joiner
    joiner_id = current_user.trip_sessions_as_joiner.last.id
    # return the bigger id concerning the trip sessions
    creator_id > joiner_id ? TripSession.find(creator_id) : TripSession.find(joiner_id)
  end

  def tic_tac_toe_creation
    # assign cross player and circle player to new tic tac toe game
    tic_tac_toe_game = TicTacToeGame.new
    tic_tac_toe_game.cross_player = find_last_trip_sessions.joiner
    tic_tac_toe_game.circle_player = find_last_trip_sessions.creator
    # save the new tic tac toe game instance in DB
    tic_tac_toe_game.save
    # return tic tac toe game
    tic_tac_toe_game
  end

  def broadcast_previous_game_match
    TicTacToeGameChannel.broadcast_to(
      @previous_game_match,
      @previous_game_match.id
    )
  end
end

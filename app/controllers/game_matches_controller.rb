class GameMatchesController < ApplicationController
  before_action :set_game_match, only: %i[show counter return]
  def show
    # Tic_tac_toe
    @tic_tac_toe_game = @game_match.matchable

    # Chifoumi
    if @game_match.matchable_type == "ChifoumiGame"
      @chifoumi_game = @game_match.matchable
      @chifoumi_player = @chifoumi_game.which_player(current_user)
      @chifoumi_competitor = @chifoumi_game.which_competitor(current_user)
      @btn_text = @chifoumi_game.play_round.zero? ? "démarrer la partie" : "prochaine manche"
    end

    # Chatroom
    @trip_session = @game_match.trip_session
    @message = Message.new
    # find buddy name to display
    @buddy = current_user == @trip_session.creator ? @trip_session.joiner.random_nickname : @trip_session.creator.random_nickname

    # Requests
    @request = Request.new
    @lastrequest = @trip_session.requests.exists? ? @trip_session.requests.last.status : nil
    class_for_send_request
    class_for_answer_request
    class_return_to_reveal_profil
    class_left_buddy_announcement
  end

  def create
    # find the previous game match of both players together before to save the next one
    @previous_game_match = find_last_trip_sessions.game_matches.last
    # create the new tic tac toe game or chifoumi game
    new_game = game_creation
    # creation of new instance of game_match and tic tac toe game
    @game_match = GameMatch.new
    # find the last trip_sessions from the last trip_sessions of current user
    @game_match.trip_session = find_last_trip_sessions
    # add the tic tac toe game id to the game match
    @game_match.matchable = new_game
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
    @trip_session.save
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

  def class_for_send_request
    @requestclass = @lastrequest.nil? ? "" : "d-none"
  end

  def class_for_answer_request
    if @lastrequest.nil? || @lastrequest == "refused"
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

  def class_return_to_reveal_profil
    if @lastrequest
      @class_return_to_reveal_profil = @lastrequest == "accepted" ? "d-block" : "d-none"
    else
      @class_return_to_reveal_profil = "d-none"
    end
  end

  def class_left_buddy_announcement
    @class_left_buddy_announcement = @trip_session.status == "closed" ? "d-block" : "d-none"
  end

  def find_last_trip_sessions
    # define last trip_sessions_as_creator
    last_trip_session_as_creator_id = current_user.trip_sessions_as_creator.last.id if current_user.trip_sessions_as_creator.last
    # define last trip_sessions_as_joiner
    last_trip_session_as_joiner_id = current_user.trip_sessions_as_joiner.last.id if current_user.trip_sessions_as_joiner.last
    # return last TripSession if joiner_id or creator_id is nil
    return TripSession.find(last_trip_session_as_creator_id) if last_trip_session_as_joiner_id.nil?
    return TripSession.find(last_trip_session_as_joiner_id) if last_trip_session_as_creator_id.nil?

    # return the last trip sessions of players
    last_trip_session_as_creator_id > last_trip_session_as_joiner_id ? TripSession.find(last_trip_session_as_creator_id) : TripSession.find(last_trip_session_as_joiner_id)
  end

  def tic_tac_toe_creation
    # assign cross player and circle player to new tic tac toe game
    tic_tac_toe_game = TicTacToeGame.new
    # define the cross and circle player with the
    random_player = find_last_trip_sessions.joiner_or_creatore
    tic_tac_toe_game.cross_player = find_last_trip_sessions.public_send(random_player[0])
    tic_tac_toe_game.circle_player = find_last_trip_sessions.public_send(random_player[1])
    # save the new tic tac toe game instance in DB
    tic_tac_toe_game.save
    # return tic tac toe game
    tic_tac_toe_game
  end

  def chifoumi_creation
    # create a new chifoumi game
    chifoumi_game = ChifoumiGame.new
    # define the first and second player with the random trip session or creator
    random_player = find_last_trip_sessions.joiner_or_creatore
    chifoumi_game.first_player = find_last_trip_sessions.public_send(random_player[0])
    chifoumi_game.second_player = find_last_trip_sessions.public_send(random_player[1])
    # save the new tic tac toe game instance in DB
    chifoumi_game.save
    # return tic tac toe game
    chifoumi_game
  end

  def game_creation
    if @previous_game_match.matchable_type == "TicTacToeGame"
      tic_tac_toe_creation
    else
      chifoumi_creation
    end
  end

  def broadcast_previous_game_match
    if @previous_game_match.matchable_type == "TicTacToeGame"
      TicTacToeGameChannel.broadcast_to(
        @previous_game_match,
        @previous_game_match.id
      )
    else
      ChifoumiGameChannel.broadcast_to(
        @previous_game_match,
        @previous_game_match.id
      )
    end
  end
end

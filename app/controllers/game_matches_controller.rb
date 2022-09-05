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

  def create
    @previous_game_match = GameMatch.find(params[:previous_game_match])
    # creation of new instance of game_match and tic tac toe game
    @tic_tac_toe_game = TicTacToeGame.new
    @game_match = GameMatch.new
    # find the last trip_sessions id from the last game_match
    @game_match.trip_session_id = @previous_game_match.trip_session_id
    # assign cross player and circle player to new tic tac toe game
    @tic_tac_toe_game.cross_player = @game_match.trip_session.joiner
    @tic_tac_toe_game.circle_player = @game_match.trip_session.creator
    # save the new tic tac toe game instance in DB
    @tic_tac_toe_game.save
    # add the tic tac toe game id to the game match
    @game_match.matchable = @tic_tac_toe_game
    # save the new game_match instance in DB
    @game_match.save
    TicTacToeGameChannel.broadcast_to(
      @previous_game_match,
      @previous_game_match.id
    )
    # redirect to game_match show
    redirect_to game_match_path(@game_match)
  end

  def counter
    @counter = 5
    @game_match = GameMatch.find(params[:id])
  end

  private

  def find_last_trip_sessions
    # define last trip_sessions_as_creator
    creator_id = current_user.trip_sessions_as_creator.last.id
    # define last trip_sessions_as_joiner
    joiner_id = current_user.trip_sessions_as_joiner.last.id
    # return the bigger id concerning the trip sessions
    creator_id > joiner_id ? creator_id : joiner_id
  end
end

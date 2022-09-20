class TripSessionsController < ApplicationController
  before_action :set_trip_session, only: %i[join_tic_tac_toe join_chifoumi destroy waiting_room]
  def new
    # Know if there is session available to join and give the active people
    if TripSession.last != nil
      if TripSession.game_matches.where(matchable_type: "TicTacToeGame").last != nil
        @active_people = TripSession.where(status: "in game").count * 2 + TripSession.where(status: "waiting for joiner").count
        @session_tic_tac_toe_game = GameMatch.where(matchable_type: "TicTacToeGame").last.trip_session
        @trip_session_tic_tac_toe_game = @session_tic_tac_toe_game if @session_tic_tac_toe_game.status == "waiting for joiner"
        @session_chifoumi = GameMatch.where(matchable_type: "ChifoumiGame").last.trip_session
        @trip_session_chifoumi = @session_chifoumi if @session_chifoumi.status == "waiting for joiner"
    else
      @active_people = 0
    end
  end

  def create_tic_tac_toe
     # Create new trip session
    @trip_session = TripSession.new
    @trip_session.status = "waiting for joiner"
    @trip_session.creator = current_user
    @trip_session.save
     # Create new TicTacToeGame
     @tic_tac_toe_game = TicTacToeGame.new
     @tic_tac_toe_game.save
     # Create new game match
     @game_match = GameMatch.new
     @game_match.trip_session = @trip_session
     @game_match.matchable = @tic_tac_toe_game
     @game_match.save
     redirect_to waiting_room_trip_session_path(@trip_session)
  end

  def create_chifoumi
    # Create new trip session
    @trip_session = TripSession.new
    @trip_session.status = "waiting for joiner"
    @trip_session.creator = current_user
    @trip_session.save
     # Create new chifoumiGame
     @chifoumi_game = ChifoumiGame.new
     # Create new game match
     @game_match = GameMatch.new
     @game_match.trip_session = @trip_session
     @game_match.matchable = @chifoumi_game
     @game_match.save
     redirect_to waiting_room_trip_session_path(@trip_session)
  end

  def join_tic_tac_toe
    # Complete infos from the trip session
    @trip_session = GameMatch.where(matchable_type: "TicTacToeGame").last.trip_session
    @trip_session.joiner = current_user
    @trip_session.status = "in game"
    @trip_session.save
    @game_match = @trip_session.game_matches.last
    # find the game
    @tic_tac_toe_game = @game_match.matchable
    # define the cross and circle player with the method random_first_player
    random_player = @trip_session.joiner_or_creatore
    @tic_tac_toe_game.cross_player = @trip_session.public_send(random_player[0])
    @tic_tac_toe_game.circle_player = @trip_session.public_send(random_player[1])
    @tic_tac_toe_game.save
    # allow to know where joiner is coming
    ListenJoinerChannel.broadcast_to(
      @trip_session,
      @game_match.id
    )
    redirect_to counter_game_match_path(@game_match)
  end

  def join_chifoumi
    # Complete infos from the trip session
    @trip_session = GameMatch.where(matchable_type: "ChifoumiGame").last.trip_session
    @trip_session.joiner = current_user
    @trip_session.status = "in game"
    @trip_session.save
    @game_match = @trip_session.game_matches.last
    # find the game
    @chifoumi_game = @game_match.matchable
    # define the cross and circle player with the method random_first_player
    random_player = @trip_session.joiner_or_creatore
    @chifoumi_game.first_player = @trip_session.public_send(random_player[0])
    @chifoumi_game.second_player = @trip_session.public_send(random_player[1])
    @chifoumi_game.save
    # allow to know where joiner is coming
    ListenJoinerChannel.broadcast_to(
      @trip_session,
      @game_match.id
    )
    redirect_to counter_game_match_path(@game_match)
  end

  def destroy
    @trip_session.game_matches.last.destroy
    @trip_session.destroy
    redirect_to new_trip_session_path, status: :see_other
  end

  def waiting_room
    @game_match = GameMatch.find_by trip_session_id: @trip_session.id
  end

  private

  def set_trip_session
    @trip_session = TripSession.find(params[:id])
  end
end

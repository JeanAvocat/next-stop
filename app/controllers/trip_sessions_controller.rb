class TripSessionsController < ApplicationController
  before_action :set_trip_session, only: %i[join destroy waiting_room]
  def new
    if TripSession.last != nil
      @trip_session = TripSession.last if TripSession.last.status == "waiting for joiner"
      @active_people = TripSession.where(status: "in game").count * 2 + TripSession.where(status: "waiting for joiner").count
    else
      @active_people = 0
    end
  end

  def create
    @trip_session = TripSession.new
    @trip_session.status = "waiting for joiner"
    @trip_session.creator = current_user
    @trip_session.save
    redirect_to waiting_room_trip_session_path(@trip_session)
  end

  def join
    @trip_session.joiner = current_user
    @trip_session.status = "in game"
    @trip_session.save
    @tic_tac_toe_game = TicTacToeGame.new
    @tic_tac_toe_game.cross_player = @trip_session.joiner
    @tic_tac_toe_game.circle_player = @trip_session.creator
    @tic_tac_toe_game.save
    @game_match = GameMatch.new
    @game_match.trip_session = @trip_session
    @game_match.matchable = @tic_tac_toe_game
    @game_match.save
    redirect_to counter_game_match_path(@game_match)
  end

  def destroy
    @trip_session.destroy
    redirect_to new_trip_session_path, status: :see_other
  end

  def waiting_room
    @game_match = GameMatch.find_by trip_session_id: @trip_session.id
    # if @trip_session.joiner_id? # TODO : convert the "if" condition in real time with ActionCable gem
    #   redirect_to counter_game_match_path(@game_match)
    # end
  end

  private

  def set_trip_session
    @trip_session = TripSession.find(params[:id])
  end
end

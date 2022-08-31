class TripSessionsController < ApplicationController
  def new
    if TripSession.last != nil
      @trip_session = TripSession.last if TripSession.last.available_for_joiner?
      @active_people = TripSession.where(status: "in game").count * 2 + TripSession.where(status: "waiting for joiner").count
    else
      @active_people = 0
    end
  end

  def create
    @tripsession = TripSession.new
    @tripsession.status = "waiting for joiner"
    @tripsession.creator = current_user
    @tripsession.save
    redirect_to waiting_room_trip_session_path(@tripsession)
  end

  def join
    @tripsession = TripSession.find[params[:id]]
    @tripsession.joiner = current_user
    @tripsession.status = "in game"
    @tripsession.save
    @gamematch = GameMatch.new
    @gamematch.trip_session = @tripsession
    @gamematch.matchable = @tictactoegame
    redirect_to trip_session_path(@tripsession)
  end

  private

  # méthode pour compter le nb de personnes connectés
end

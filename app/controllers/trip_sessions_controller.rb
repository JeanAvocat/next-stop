class TripSessionsController < ApplicationController
  def new
    if @tripsession != nil
      @tripsession = TripSession.all
      countpeople
    else
      @numberconnected = 0
      @tripsession = []
    end
  end

  def create
    @tripsession = TripSession.new
    @tripsession.status = "waiting for joiner"
    @tripsession.creator = current_user
    @tripsession.save
    redirect_to trip_session_path(@tripsession)
  end

  def join
    @tripsessions = TripSession.all
    @tripsession = @tripsessions.last
    @tripsession.joiner = current_user
    @tripsession.status = "waiting for joiner"
    redirect_to trip_session_path(@tripsession)
  end

  private

  # méthode pour compter le nb de personnes connectés
  def countpeople
    @numberconnected = 0
    @tripsession.each do |session|
      if (session.creator != []) && (session.joiner != [])
        @numberconnected += 2
      else
        @numberconnected += 1
      end
    end
  end
end

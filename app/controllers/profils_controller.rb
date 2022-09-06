class ProfilsController < ApplicationController
  def reveal_profil
    # find the game match and the trip session
    @game_match = GameMatch.find(params[:game_match_id])
    @trip_session = @game_match.trip_session
    @request = @trip_session.requests.last
    if (@request == nil) || (@request.status != "accepted")
      @accept = false
    else
      @accept = true
    end
  end
end

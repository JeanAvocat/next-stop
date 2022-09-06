class ProfilsController < ApplicationController
  def reveal_profil
    # find the game match and the trip session
    @game_match = GameMatch.find(params[:game_match_id])
    @trip_session = @game_match.trip_session
    RequestChannel.broadcast_to(
      @game_match,
      "reveal"
    )
    game_match_reveal_profil_path(@game_match)
  end
end

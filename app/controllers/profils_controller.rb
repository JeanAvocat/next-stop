class ProfilsController < ApplicationController
  def reveal_profil
    # find the game match and the trip session
    @game_match = GameMatch.find(params[:game_match_id])
    @trip_session = @game_match.trip_session
    @request = @trip_session.requests.last
    # Check if players have a phone number and an Instagram account
    @class_for_creator_instagram_existance = @trip_session.creator.instagram_account.empty? ? "d-none" : "d-block"
    @class_for_creator_phone_existance = @trip_session.creator.phone_number.empty? ? "d-none" : "d-block"
    @class_for_joiner_instagram_existance = @trip_session.joiner.instagram_account.empty? ? "d-none" : "d-block"
    @class_for_joiner_phone_existance = @trip_session.joiner.phone_number.empty? ? "d-none" : "d-block"
    if (@request == nil) || (@request.status != "accepted")
      @accept = false
    else
      @accept = true
    end
  end
end

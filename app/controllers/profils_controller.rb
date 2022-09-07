class ProfilsController < ApplicationController
  def my_profil
    # target all the users
    @users = User.all
    # order by score
    @users.order(score: :desc)
    # allow to now the ranking of the current user
    @rankuser = 1
    rank = 0
     while current_user.email != @users[rank].email
       @rankuser += 1
       rank += 1
     end
  end

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

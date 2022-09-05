class ReturnGameMatchChannel < ApplicationCable::Channel
  def subscribed
    game_match = GameMatch.find(params[:id])
    stream_for game_match
  end

  def unsubscribed
  end
end

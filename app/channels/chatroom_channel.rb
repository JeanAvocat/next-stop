class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    game_match = GameMatch.find(params[:id])
    stream_for game_match
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

class ListenJoinerChannel < ApplicationCable::Channel
  def subscribed
    trip_session = TripSession.find(params[:id])
    stream_for trip_session
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

class MessagesController < ApplicationController
  def create
    @game_match = current_user.trip_sessions.last.game_matches.last
    @message = Message.new(message_params)
    @message.trip_session_id = current_user.trip_sessions.last.id
    @message.user_id = current_user.id
    if @message.save
      redirect_to game_match_path(@game_match)
    else
      render "chatrooms/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end

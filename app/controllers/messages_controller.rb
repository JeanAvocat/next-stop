class MessagesController < ApplicationController
  def create
    @game_match = GameMatch.find(params[:game_match_id])
    @message = Message.new(message_params)
    @message.trip_session_id = @game_match.trip_session_id
    @message.user_id = current_user.id
    if @message.save
      ChatroomChannel.broadcast_to(
        @game_match,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok
    else
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end

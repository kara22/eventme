class MessagesController < ApplicationController
  def create
    # @match = Match.find(params[:match_id])
    # @message = Message.new(message_params)
    # @message.sender = current_user
    # @message.recipient = @match.user_1 == current_user ? @match.user_2 : @match.user_1
    # @message.save
  end

  def destroy

  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end

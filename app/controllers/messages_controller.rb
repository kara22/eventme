class MessagesController < ApplicationController
  def create
    @match = Match.find(params[:match_id])
    @message = Message.new(message_params)
    @message.sender = current_user
    @message.recipient = @match.user_1 == current_user ? @match.user_2 : @match.user_1
    @message.match = @match
    @message.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
      end
    authorize @message
  end

  def destroy

  end

  private

  def message_params
    params.require(:message).permit(:content, :sender_id, :recipient_id)
  end
end

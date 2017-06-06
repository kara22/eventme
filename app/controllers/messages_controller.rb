class MessagesController < ApplicationController
  def create
    @match = Match.find(params[:match_id])
    @message = Message.new(message_params)
    @user_messages = Message.where(sender_id: current_user)
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
    params.require(:message).permit(:content)
  end
end

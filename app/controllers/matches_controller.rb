class MatchesController < ApplicationController
  def index
    @matches = policy_scope(Match.where("user_1_id = ? OR user_2_id = ?", current_user.id, current_user.id))
  end

  def show
    authorize current_user
    @match = Match.find(params[:id])
    @message = Message.new
    @messages = @match.messages.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
  end


  def destroy
    @match = Match.find(params[:id])
    if @match.destroy
      redirect_to matches_path
    else
      redirect_to matches_path
    end
  end
end

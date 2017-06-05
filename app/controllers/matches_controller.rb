class MatchesController < ApplicationController
  def index
    @matches = policy_scope(Match.where("user_1_id = ? OR user_2_id = ?", current_user.id, current_user.id))
  end
end

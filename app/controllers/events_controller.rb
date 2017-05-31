class EventsController < ApplicationController
  def index
    @events = current_user.events.going
    @events = policy_scope(Event).order(created_at: :desc)
  end

end

class DecisionsController < ApplicationController
  def create
    # récupérer les params depuis la méthode search (id du decision maker et receiver)
    # créer une nouvelle décision en fonction de l'id du bouton concerné (like ou dislike)
    # faire une requete ajax qui permet de passer à la div suivante
    # si le profil liké par le current_user a préalablement pris une décision positive
    # une pop pu devra s'afficher au clic du like et proposer de lancer une conversation
    @decision = Decision.new(decisions_params)
    authorize @decision
    puts 'entering create controller'
    @match = nil
    # puts @match.user_2.first_name
    if @decision.save
      # @decision = decision_maker: current_user, decision_receiver: params
      # check si il ya reciprocité
      reciproc_decision = Decision.where(decision_receiver: @decision.decision_maker, decision_maker: @decision.decision_receiver, event: @decision.event).first
      if reciproc_decision != nil
        @decision.update(pending: false)
        reciproc_decision.update(pending: false)
        if @decision.like && reciproc_decision.like
          @match = Match.create(user_1: @decision.decision_maker, user_2: @decision.decision_receiver, event_id: @decision.event_id)
        end
      end
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'users/search' }
        format.js
      end
    end
  end


  private

  def decisions_params
    params.require(:decision).permit(:event_id, :decision_maker_id,
                                     :decision_receiver_id, :like, :pending)
  end
end

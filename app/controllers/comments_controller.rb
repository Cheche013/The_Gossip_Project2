class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create]
  before_action :set_gossip  # on récupère le potin parent grâce à :gossip_id

  def create
    @comment = @gossip.comments.new(comment_params)
    @comment.user = current_user  # auteur = utilisateur connecté (si non connecté, ça échouera pour l’instant)

    if @comment.save
      redirect_to @gossip, notice: "Commentaire ajouté."
    else
      redirect_to @gossip, alert: "Impossible d’ajouter le commentaire."
    end
  end

  private

  def set_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end

  def comment_params
    params.require(:comment).permit(:content)  # pas de :user_id ici
  end
end

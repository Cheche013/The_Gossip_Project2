class LikesController < ApplicationController
  before_action :authenticate_user!   # AJOUT : il faut être connecté
  before_action :set_gossip           # AJOUT : on récupère le potin parent

  def create
    like = @gossip.likes.find_or_initialize_by(user: current_user) # un seul like par user
    if like.persisted?
      redirect_back fallback_location: @gossip, notice: "Tu as déjà liké ce potin."
    elsif like.save
      redirect_back fallback_location: @gossip, notice: "Like ajouté."
    else
      redirect_back fallback_location: @gossip, alert: "Impossible de liker."
    end
  end

  def destroy
    like = @gossip.likes.find_by(id: params[:id], user: current_user)
    if like
      like.destroy
      redirect_back fallback_location: @gossip, notice: "Like retiré."
    else
      redirect_back fallback_location: @gossip, alert: "Like introuvable."
    end
  end

  private

  def set_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end
end

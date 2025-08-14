class ApplicationController < ActionController::Base
  include SessionsHelper  # doit déjà être présent

  private

  # AJOUT : bloque l’accès si pas connecté
  def authenticate_user!
    unless logged_in?
      flash[:alert] = "Merci de te connecter."
      redirect_to login_path
    end
  end
end
class GossipsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :destroy]  # accès réservé aux connectés
  before_action :set_gossip,        only: %i[ show edit update destroy ]
  before_action :authorize_owner!,  only: %i[ edit update destroy ]                           # seul l’auteur peut modifier/supprimer

  # GET /gossips
  def index
    @gossips = Gossip.all
  end

  # GET /gossips/1
  def show; end

  # GET /gossips/new
  def new
    @gossip = Gossip.new
  end

  # GET /gossips/1/edit
  def edit; end

  # POST /gossips
  def create
    @gossip = Gossip.new(gossip_params)
    @gossip.user = current_user  # associer l’auteur connecté

    respond_to do |format|
      if @gossip.save
        format.html { redirect_to @gossip, notice: "Gossip was successfully created." }
        format.json { render :show, status: :created, location: @gossip }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @gossip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gossips/1
  def update
    respond_to do |format|
      if @gossip.update(gossip_params)
        format.html { redirect_to @gossip, notice: "Gossip was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @gossip }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @gossip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gossips/1
  def destroy
    @gossip.destroy!
    respond_to do |format|
      format.html { redirect_to gossips_path, notice: "Gossip was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_gossip
    @gossip = Gossip.find(params[:id])  # FIX : pas de params.expect
  end

  def gossip_params
    params.require(:gossip).permit(:title, :content, :city_id)  # pas de :user_id ici
  end

  def authorize_owner!
    return if @gossip.user == current_user

    flash[:alert] = "Accès refusé : tu n'es pas l'auteur de ce potin."
    redirect_to @gossip
  end
end

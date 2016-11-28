class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:show, :edit, :update, :destroy]

  # GET /contributions
  # GET /contributions.json
  def index
    if (current_user!= nil)
      @puntuations = Puntuation.where(user_id: current_user.id)
    end
    sort = params[:sort]
    type = params[:type]
    user = params[:user]
    if (user!=nil)
      @contributions = Contribution.where(user_id: user).order(created_at: :desc)
    elsif (sort == 'date')
      @contributions = Contribution.order(created_at: :desc)
    elsif (type == 'text')
      @contributions = Contribution.where(url: nil).order(puntuation: :desc)
    else
      @contributions = Contribution.where(text: nil).order(puntuation: :desc)
    end
  end
  
  # GET /contributions/1
  # GET /contributions/1.json
  def show
    if (current_user!= nil)
      @puntuations = Puntuation.where(user_id: current_user.id)
      @puntuations_com = CommentPuntuation.where(user_id: current_user.id)
      @puntuations_rep = ReplyPuntuation.where(user_id: current_user.id)
    end
  end

  # GET /contributions/new
  def new
    @contribution = Contribution.new
  end 

  # GET /contributions/1/edit
  def edit
  end

  # POST /contributions
  # POST /contributions.json
  def create
    @contribution = Contribution.new(contribution_params)
    @contribution.user_id = current_user.id
    
    respond_to do |format|
      if @contribution.save
        format.html { redirect_to action: "index",sort:"date"}
      else
        format.html { render :new }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contributions/1
  # PATCH/PUT /contributions/1.json
  def update
    respond_to do |format|
      if @contribution.update(contribution_params)
        format.html { redirect_to @contribution, notice: 'Contribution was successfully updated.' }
        format.json { render :show, status: :ok, location: @contribution }
      else
        format.html { render :edit }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contributions/1
  # DELETE /contributions/1.json
  def destroy
    @contribution.destroy
    respond_to do |format|
      format.html { redirect_to contributions_url, notice: 'Contribution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribution
      @contribution = Contribution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contribution_params
      params.require(:contribution).permit(:title, :url, :text, :puntuation, :user_id)
    end
    
end
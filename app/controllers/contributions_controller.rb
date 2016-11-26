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
  
  def api_get
    type = params[:type]
    if (type == nil)
      @contributions = Contribution.order(puntuation: :desc)
      render_contributions(@contributions, 200)
    elsif (type == 'url') 
      @contributions = Contribution.where(text: nil).order(puntuation: :desc)
      render_contributions(@contributions, 200)
    elsif (type == 'ask')
      @contributions = Contribution.where(url: nil).order(puntuation: :desc)
      render_contributions(@contributions, 200)
    else
      render :json => {"Error": "Type not allowed"}.to_json, status: 400
    end
  end
  
  def api_post
    @contribution = Contribution.new(contribution_params_api)
    if @contribution.text != nil && @contribution.url !=nil
      render :json => {"Error": "Conflict on creating contribution. It can't have text and url"}.to_json, status: 409
    else
      @contribution.save
      render_contribution(@contribution, 201)
    end
    # FALTA CONTROLAR LA RESPOSTA 401
  end
  
  def api_show
    @contribution = Contribution.where(id: params[:id])
    if @contribution[0] == nil
      render :json => {"Error": "Contribution not found"}.to_json, status: 404
    else
      render_contribution(@contribution[0], 200)
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
    
    def contribution_params_api
      params.require(:contribution).permit(:title, :url, :text, :user_id)
    end
    
    def render_contributions(contributions, status)
      array = []
      contributions.each do | contribution |
        array << {
          id: contribution.id,
          title: contribution.title,
          content: contribution.url || contribution.text,
          created_at: contribution.created_at,
          user:{
            url: '/users/%d' % [contribution.user_id]
          },
          puntuation: contribution.puntuation,
          comments: contribution.comments.size
        }
      end
      render :json => array.to_json, status: status
    end
    
    def render_contribution(contribution, status)
      render :json => {
          id: contribution.id,
          title: contribution.title,
          content: contribution.url || contribution.text,
          created_at: contribution.created_at,
          user:{
            url: '/users/%d' % [contribution.user_id]
          },
          puntuation: contribution.puntuation,
          comments: contribution.comments.size
        }.to_json, status: status
    end
end

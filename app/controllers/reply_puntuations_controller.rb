class ReplyPuntuationsController < ApplicationController
  before_action :set_reply_puntuation, only: [:show, :edit, :update, :destroy]

  # GET /reply_puntuations
  # GET /reply_puntuations.json
  def index
    @reply_puntuations = ReplyPuntuation.all
  end

  # GET /reply_puntuations/1
  # GET /reply_puntuations/1.json
  def show
  end

  # GET /reply_puntuations/new
  def new
    @reply_puntuation = ReplyPuntuation.new
  end

  # GET /reply_puntuations/1/edit
  def edit
  end

  # POST /reply_puntuations
  # POST /reply_puntuations.json
  def create
    @reply_puntuation = ReplyPuntuation.new(reply_puntuation_params)

    respond_to do |format|
      if @reply_puntuation.save
        format.html { redirect_to :back }
        format.json { render :show, status: :created, location: @reply_puntuation }
      else
        format.html { render :new }
        format.json { render json: @reply_puntuation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reply_puntuations/1
  # PATCH/PUT /reply_puntuations/1.json
  def update
    respond_to do |format|
      if @reply_puntuation.update(reply_puntuation_params)
        format.html { redirect_to @reply_puntuation, notice: 'Reply puntuation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reply_puntuation }
      else
        format.html { render :edit }
        format.json { render json: @reply_puntuation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reply_puntuations/1
  # DELETE /reply_puntuations/1.json
  def destroy
    @reply_puntuation.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply_puntuation
      @reply_puntuation = ReplyPuntuation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_puntuation_params
      params.require(:reply_puntuation).permit(:reply_id, :user_id)
    end
end

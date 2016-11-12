class PuntuationsController < ApplicationController
  before_action :set_puntuation, only: [:show, :edit, :update, :destroy]

  # GET /puntuations
  # GET /puntuations.json
  def index
    @puntuations = Puntuation.all
  end

  # GET /puntuations/1
  # GET /puntuations/1.json
  def show
  end

  # GET /puntuations/new
  def new
    @puntuation = Puntuation.new
  end

  # GET /puntuations/1/edit
  def edit
  end

  # POST /puntuations
  # POST /puntuations.json
  def create
    @puntuation = Puntuation.new(puntuation_params)

    respond_to do |format|
      if @puntuation.save
        format.html { redirect_to "/" }
        format.json { render :show, status: :created, location: @puntuation }
      else
        format.html { render :new }
        format.json { render json: @puntuation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /puntuations/1
  # PATCH/PUT /puntuations/1.json
  def update
    respond_to do |format|
      if @puntuation.update(puntuation_params)
        format.html { redirect_to @puntuation, notice: 'Puntuation was successfully updated.' }
        format.json { render :show, status: :ok, location: @puntuation }
      else
        format.html { render :edit }
        format.json { render json: @puntuation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /puntuations/1
  # DELETE /puntuations/1.json
  def destroy
    @puntuation.destroy
    respond_to do |format|
      format.html { redirect_to "/" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_puntuation
      @puntuation = Puntuation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def puntuation_params
      params.require(:puntuation).permit(:user_id, :contribution_id)
    end
end

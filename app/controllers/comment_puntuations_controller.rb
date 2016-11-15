class CommentPuntuationsController < ApplicationController
  before_action :set_comment_puntuation, only: [:show, :edit, :update, :destroy]

  # GET /comment_puntuations
  # GET /comment_puntuations.json
  def index
    @comment_puntuations = CommentPuntuation.all
  end

  # GET /comment_puntuations/1
  # GET /comment_puntuations/1.json
  def show
  end

  # GET /comment_puntuations/new
  def new
    @comment_puntuation = CommentPuntuation.new
  end

  # GET /comment_puntuations/1/edit
  def edit
  end

  # POST /comment_puntuations
  # POST /comment_puntuations.json
  def create
    @comment_puntuation = CommentPuntuation.new(comment_puntuation_params)

    respond_to do |format|
      if @comment_puntuation.save
        format.html { redirect_to :back }
        format.json { render :show, status: :created, location: @comment_puntuation }
      else
        format.html { render :new }
        format.json { render json: @comment_puntuation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comment_puntuations/1
  # PATCH/PUT /comment_puntuations/1.json
  def update
    respond_to do |format|
      if @comment_puntuation.update(comment_puntuation_params)
        format.html { redirect_to @comment_puntuation, notice: 'Comment puntuation was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment_puntuation }
      else
        format.html { render :edit }
        format.json { render json: @comment_puntuation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comment_puntuations/1
  # DELETE /comment_puntuations/1.json
  def destroy
    @comment_puntuation.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment_puntuation
      @comment_puntuation = CommentPuntuation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_puntuation_params
      params.require(:comment_puntuation).permit(:comment_id, :user_id)
    end
end

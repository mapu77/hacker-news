class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :update, :destroy]

  # GET /replies
  # GET /replies.json
  def index
    @replies = Reply.all
  end
  
  def api_get
    status = 200
    if params[:contribution_id] != nil and params[:user_id] != nil
      @replies = Reply.where(comment_id: params[:comment_id]).where(user_id: params[:user_id])
    elsif params[:comment_id] != nil
      @replies = Reply.where(comment_id: params[:comment_id])
    else
      @replies = Reply.where(user_id: params[:user_id])
    end
    if @replies == nil
      status = 404
    end
    render :json => @replies, status: status
  end
  
  def api_show
    @reply = Reply.where(id: params[:id])
    if @reply[0] == nil
      render :json => {"Error": "Reply not found"}.to_json, status: 404
    else
      render :json => @reply, status: 200
    end
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
  end

  # GET /replies/new
  def new
    @comment = Comment.find(params[:coment])
    @reply = Reply.new
  end

  # GET /replies/1/edit
  def edit
  end

  # POST /replies
  # POST /replies.json
  def create
    @reply = Reply.new(reply_params)

    respond_to do |format|
      if @reply.save
        format.html {  redirect_to @reply.comment.contribution, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @reply }
      else
        format.html { redirect_to @reply.comment.contribution }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /replies/1
  # PATCH/PUT /replies/1.json
  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to @reply, notice: 'Reply was successfully updated.' }
        format.json { render :show, status: :ok, location: @reply }
      else
        format.html { render :edit }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply.destroy
    respond_to do |format|
      format.html { redirect_to replies_url, notice: 'Reply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_params
      params.require(:reply).permit(:content, :user_id, :comment_id)
    end
end

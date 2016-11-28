class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    sort = params[:sort]
    id = params[:id]
    if (sort == 'date')
      @comments = Contribution.order(created_at: :desc)
    else
      comments = Comment.where(user_id: id).order(created_at: :desc)
      replies = Reply.where(user_id: id).order(created_at: :desc)
      @all = comments + replies
      @all.sort_by { |f| [f.created_at] }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.contribution, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment.contribution_id }
      else
        format.html { redirect_to @comment.contribution }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :contribution_id)
    end

    def render_comments(comments, status)
      json = []
      comments.each do | comment |
        json << {
          id: comment.id,
          contribution:{
            url: '/contributions/%d' % [comment.contribution_id]
          },
          user:{
            url: '/users/%d' % [comment.user_id]
          },
          content: comment.content,
          punctuation: comment.comment_puntuations.size,
          created_at: comment.created_at,
          replies: comment.replies.size
        }
      end
      render :json => json.to_json, status: status
    end
    
    def render_comment(comment, status)
      render :json => {
          id: comment.id,
          contribution:{
            url: '/contributions/%d' % [comment.contribution_id]
          },
          user:{
            url: '/users/%d' % [comment.user_id]
          },
          content: comment.content,
          punctuation: comment.comment_puntuations.size,
          created_at: comment.created_at,
          replies: comment.replies.size
        }.to_json, status: status
    end
end

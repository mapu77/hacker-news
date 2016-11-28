class CommentsApiController < ApplicationController
    before_action :authenticate
    after_action :cors_set_access_control_headers
    
    def get_comments
        if @flag == 0
          if params[:contribution_id] != nil and params[:user_id] != nil
            if User.exists?(params[:user_id]) and Contribution.exists?(params[:contribution_id])
              @comments = Comment.where(contribution_id: params[:contribution_id], user_id: params[:user_id])
              render_comments(@comments, 200)
            else
              render :json => {"Error": "User and contribution not found"}, status: 404
            end
          elsif params[:contribution_id] != nil
            if Contribution.exists?(params[:contribution_id])
              @comments = Comment.where(contribution_id: params[:contribution_id])
              render_comments(@comments, 200)
            else
              render :json => {"Error": "Contribution not found"}, status: 404
            end
          elsif params[:user_id] != nil
            if User.exists?(params[:user_id])
              @comments = Comment.where(user_id: params[:user_id])
              render_comments(@comments, 200)
            else
              render :json => {"Error": "User not found"}, status: 404
            end
          else
              @comments = Comment.all
              render_comments(@comments, 200)
          end
        end
    end
  
    def post_comments
        if @flag == 0
          @comment = Comment.new(comment_params)
          if @user[0].id != @comment.user_id
            render :json => {"Error": "Unauthorized user"}, status: 401
          else
            if @comment.content.blank?
              render :json => {"Error": "Text can not be blank"}, status: 400
            else
              if Contribution.exists?(params[:contribution_id])
                @comment.save
                render_comment(@comment, 201)
              else
                render :json => {"Error": "Contribution not found"}, status: 404
              end
            end
          end
        end
    end
  
    def show_comments
        if @flag == 0
          @comment = Comment.where(id: params[:id])
          if @comment[0] == nil
            render :json => {"Error": "Comment not found"}.to_json, status: 404
          else
            render_comment(@comment[0], 200)
          end
        end
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
    
    def comment_params
      params.permit(:content, :user_id, :contribution_id)
    end
end

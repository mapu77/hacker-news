class PuntuationsApiController < ApplicationController
    before_action :authenticate
    after_action :cors_set_access_control_headers
    
    def post_puntuations
      if @flag == 0
        if ((params[:contribution_id]!=nil && params[:reply_id]!=nil && params[:comment_id]!=nil) ||
           (params[:contribution_id]==nil && params[:reply_id]!=nil && params[:comment_id]!=nil) ||
           (params[:contribution_id]!=nil && params[:reply_id]==nil && params[:comment_id]!=nil) ||
           (params[:contribution_id]!=nil && params[:reply_id]!=nil && params[:comment_id]==nil))
          render :json => {"Error": "Too many parameters"}.to_json, status: 400
        elsif (params[:contribution_id]==nil && params[:reply_id]==nil && params[:comment_id]==nil)
          render :json => {"Error": "Parameters cannot be blank"}.to_json, status: 400
        elsif params[:contribution_id] != nil
          @puntuation = Puntuation.new(puntuation_params_api)
          #VOTE CONTRIBUTION
          if @user[0].id != @puntuation.user_id
            render :json => {"Error": "Unauthorized user"}, status: 401
          elsif Contribution.exists?(params[:contribution_id])
            if Puntuation.exists?(user_id: params[:user_id], contribution_id:  params[:contribution_id])
              render :json => {"Error": "The user has already voted this contribution"}.to_json, status: 409
            else
              @puntuation.save
              render :json => {"Status": "Vote contribution created"}.to_json, status: 201
            end
          else
            render :json => {"Error": "Contribution not found"}.to_json, status: 404
          end
        elsif params[:comment_id] != nil
          @puntuation = CommentPuntuation.new(comment_puntuation_params_api)
          #VOTE COMMENT
          if @user[0].id != @puntuation.user_id
            render :json => {"Error": "Unauthorized user"}, status: 401
          elsif Comment.exists?(params[:comment_id])
            if CommentPuntuation.exists?(user_id: params[:user_id], comment_id: params[:comment_id])
              render :json => {"Error": "The user has already voted this comment"}.to_json, status: 409
            else
              @puntuation.save
              render :json => {"Status": "Vote comment created"}.to_json, status: 201
            end
          else
            render :json => {"Error": "Comment not found"}.to_json, status: 404
          end
        else
          @puntuation = ReplyPuntuation.new(reply_puntuation_params_api)
          #VOTE COMMENT
          if @user[0].id != @puntuation.user_id
            render :json => {"Error": "Unauthorized user"}, status: 401
          elsif Reply.exists?(params[:reply_id])
            if ReplyPuntuation.exists?(user_id: params[:user_id], reply_id: params[:reply_id])
              render :json => {"Error": "The user has already voted this reply"}.to_json, status: 409
            else
              @puntuation.save
              render :json => {"Status": "Vote reply created"}.to_json, status: 201
            end
          else
            render :json => {"Error": "Reply not found"}.to_json, status: 404
          end
        end
      end
    end
    
    def delete_puntuations
      if @flag == 0
        if ((params[:contribution_id]!=nil && params[:reply_id]!=nil && params[:comment_id]!=nil) ||
           (params[:contribution_id]==nil && params[:reply_id]!=nil && params[:comment_id]!=nil) ||
           (params[:contribution_id]!=nil && params[:reply_id]==nil && params[:comment_id]!=nil) ||
           (params[:contribution_id]!=nil && params[:reply_id]!=nil && params[:comment_id]==nil))
          render :json => {"Error": "Too many parameters"}.to_json, status: 400
        elsif (params[:contribution_id]==nil && params[:reply_id]==nil && params[:comment_id]==nil)
          render :json => {"Error": "Parameters cannot be blank"}.to_json, status: 400
        elsif params[:contribution_id] != nil
          #UNVOTE CONTRIBUTION
          @puntuation = Puntuation.new(puntuation_params_api)
          if @user[0].id != @puntuation.user_id
            render :json => {"Error": "Unauthorized user"}, status: 401
          elsif Contribution.exists?(params[:contribution_id])
            if Puntuation.exists?(user_id: params[:user_id], contribution_id:  params[:contribution_id])
              Puntuation.destroy_all(user_id: params[:user_id], contribution_id: params[:contribution_id])
            end
            render :json => {"Error": "Successful response"}.to_json, status: 200
          else
            render :json => {"Error": "Contribution not found"}.to_json, status: 404
          end
        elsif params[:comment_id] != nil
          #UNVOTE COMMENT
          @puntuation = CommentPuntuation.new(puntuation_params_api)
          if @user[0].id != @puntuation.user_id
            render :json => {"Error": "Unauthorized user"}, status: 401
          elsif Comment.exists?(params[:comment_id])
            if CommentPuntuation.exists?(user_id: params[:user_id], comment_id: params[:comment_id])
              CommentPuntuation.destroy_all(user_id: params[:user_id], comment_id: params[:comment_id])
            end
            render :json => {"Error": "Successful response"}.to_json, status: 200
          else
            render :json => {"Error": "Comment not found"}.to_json, status: 404
          end  
        else
          #UNVOTE REPLY
          @puntuation = ReplyPuntuation.new(puntuation_params_api)
          if @user[0].id != @puntuation.user_id
            render :json => {"Error": "Unauthorized user"}, status: 401
          elsif Reply.exists?(params[:reply_id])
            if ReplyPuntuation.exists?(user_id: params[:user_id], reply_id: params[:reply_id])
              ReplyPuntuation.destroy_all(user_id: params[:user_id], reply_id: params[:reply_id])
            end
            render :json => {"Error": "Successful response"}.to_json, status: 200
          else
            render :json => {"Error": "Reply not found"}.to_json, status: 404
          end
        end
      end
    end
    
    private
    
      def puntuation_params_api
        params.permit(:user_id, :contribution_id)
      end
      
      def comment_puntuation_params_api
        params.permit(:comment_id, :user_id)
      end
      
      def reply_puntuation_params_api
        params.permit(:reply_id, :user_id)
      end
      
    #   def render_puntuation(puntuation, status)
    #   render :json => {
    #       id: .id,
    #       contribution:{
    #         url: '/contributions/%d' % [comment.contribution_id]
    #       },
    #       user:{
    #         url: '/users/%d' % [comment.user_id]
    #       },
    #       content: comment.content,
    #       punctuation: comment.comment_puntuations.size,
    #       created_at: comment.created_at,
    #       replies: comment.replies.size
    #     }.to_json, status: status
    # end
end

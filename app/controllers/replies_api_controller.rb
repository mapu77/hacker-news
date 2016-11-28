class RepliesApiController < ApplicationController
    before_action :authenticate
    after_action :cors_set_access_control_headers
    
    def get_replies
        if @flag == 0
          if params[:comment_id] != nil and params[:user_id] != nil
            if User.exists?(params[:user_id]) and Comment.exists?(params[:comment_id])
              @replies = Reply.where(comment_id: params[:comment_id], user_id: params[:user_id])
              render_replies(@replies, 200)
            else
              render :json => {"Error": "User and comment not found"}, status: 404
            end
          elsif params[:comment_id] != nil
            if Comment.exists?(params[:comment_id])
              @replies = Reply.where(comment_id: params[:comment_id])
              render_replies(@replies, 200)
            else
              render :json => {"Error": "Comment not found"}, status: 404
            end
          elsif params[:user_id] != nil
            if User.exists?(params[:user_id])
              @replies = Reply.where(user_id: params[:user_id])
              render_replies(@replies, 200)
            else
              render :json => {"Error": "User not found"}, status: 404
            end
          else
              @replies = Reply.all
              render_replies(@replies, 200)
          end
        end
    end
  
    def post_replies
        if @flag == 0
          @reply = Reply.new(reply_params)
          if @user[0].id != @reply.user_id
            render :json => {"Error": "Unauthorized user"}, status: 401
          else
            if @reply.content.blank?
              render :json => {"Error": "Content can not be blank"}, status: 400
            else
              if Comment.exists?(params[:comment_id])
                @reply.save
                render_reply(@reply, 201)
              else
                render :json => {"Error": "Comment not found"}, status: 404
              end
            end
          end
        end
    end
  
    def show_replies
        if @flag == 0
          @reply = Reply.where(id: params[:id])
          if @reply[0] == nil
            render :json => {"Error": "Comment not found"}.to_json, status: 404
          else
            render_reply(@reply[0], 200)
          end
        end
    end
    
    def render_replies(replies, status)
      json = []
      replies.each do | reply |
        json << {
          id: reply.id,
          comment:{
            url: '/comments/%d' % [reply.comment_id]
          },
          user:{
            url: '/users/%d' % [reply.user_id]
          },
          content: reply.content,
          punctuation: reply.reply_puntuations.size,
          created_at: reply.created_at,
        }
      end
      render :json => json.to_json, status: status
    end
    
    def render_reply(reply, status)
      render :json => {
          id: reply.id,
          comment:{
            url: '/comment/%d' % [reply.comment_id]
          },
          user:{
            url: '/users/%d' % [reply.user_id]
          },
          content: reply.content,
          punctuation: reply.reply_puntuations.size,
          created_at: reply.created_at,
        }.to_json, status: status
    end
    
    def reply_params
      params.permit(:content, :user_id, :comment_id)
    end
end

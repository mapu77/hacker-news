class ContributionsApiController < ApplicationController
    before_action :authenticate
    after_action :cors_set_access_control_headers
    
    def get_contributions
        if @flag == 0
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
    end
    
    def post_contributions
        @contribution = Contribution.new(contribution_params_api)
        if @flag == 0
          if @user[0].id != @contribution.user_id
            render :json => {"Error": "Unauthorized user"}.to_json, status: 401
          elsif @contribution.text != nil && @contribution.url !=nil
            render :json => {"Error": "Conflict on creating contribution. It can't have text and url"}.to_json, status: 409
          elsif @contribution.text == nil && @contribution.url ==nil
            render :json => {"Error": "Bad request. URL or Text may be set"}.to_json, status: 400
          else
            @contribution.save
            render_contribution(@contribution, 201)
          end
        end
     end
  
    def show_contributions
        @contribution = Contribution.where(id: params[:id])
        if @flag == 0
          if @contribution[0] == nil
            render :json => {"Error": "Contribution not found"}.to_json, status: 404
          else
            render_contribution(@contribution[0], 200)
          end
        end
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
            url: '/users/%d' % [contribution.user_id],
            name: contribution.user.name
          },
          puntuation: contribution.puntuation,
          comments: contribution.comments.size
        }.to_json, status: status
    end
    
    def contribution_params_api
      params.permit(:title, :url, :text, :user_id)
    end
end

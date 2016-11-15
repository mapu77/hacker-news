class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :contribution
    has_many :replies
    has_many :comment_puntuations
    
end

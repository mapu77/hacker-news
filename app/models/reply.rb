class Reply < ApplicationRecord
    belongs_to :user
    belongs_to :comment
    has_many :reply_puntuations
    validates :content, presence: true
    
end

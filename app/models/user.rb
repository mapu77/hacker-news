class User < ApplicationRecord
    has_many :contributions
    validates :username, presence: true
    validates :password, presence: true
end

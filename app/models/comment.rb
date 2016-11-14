class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :contribution
    has_many :replies
    before_save :convert_blank_to_nil
    validate :presenceContent

  def presenceContent
    if (content.blank?)
      errors[:base] << "A comment needs to be provided"
    end
  end
    
end

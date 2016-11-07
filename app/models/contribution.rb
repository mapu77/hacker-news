class Contribution < ApplicationRecord
  belongs_to :user
  before_save :convert_blank_to_nil
  validates :title, presence: true
  validate :presenceURLorText

  def convert_blank_to_nil
      self.puntuation = 0
      if self.url.blank?
          self.url = nil
      end
      if self.text.blank?
          self.text = nil
      end
  end
  
  def presenceURLorText
    if (url.blank? and text.blank?)
      errors[:base] << "A text or a url needs to be provided"
    elsif not (url.blank? ^ text.blank?)
      errors[:base] << "A text or a url needs to be provided, not both"
    end
  end
      
end

class Comment < ActiveRecord::Base
  belongs_to :link

  after_save :update_link

  def vote_up
  	self.score += 1
  end

  def update_link
  	if self.link.present?
      self.link.update_score
  	end
  end
end
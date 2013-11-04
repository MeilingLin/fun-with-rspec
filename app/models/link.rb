class Link < ActiveRecord::Base
  belongs_to :user
  has_many :comments

	def update_score
	  total = 0

		self.comments.each do |comment|
			total += comment.score
		end
 
		self.score = total
		self.save
  end

end

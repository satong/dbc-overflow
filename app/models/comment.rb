class Comment < ActiveRecord::Base
  has_many :votes, as: :votable
  belongs_to :user
  belongs_to :commentable, polymorphic: true


  def get_route
    "/comments/#{self.id}"
  end

  def get_redirect_route
    "/questions/#{self.commentable.id}" if self.commentable_type == "Question"
    "/questions/#{self.commentable.question_id}" if self.commentable_type == "Answer"
  end

end

class Comment < ActiveRecord::Base
  has_many :votes, as: :votable
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :body, presence: true

  def get_route
    "/comments/#{self.id}"
  end

  def get_redirect_route
    if self.commentable_type == "Question"
      return "/questions/#{self.commentable.id}"
    elsif self.commentable_type == "Answer"
      return "/questions/#{self.commentable.question_id}"
    end
  end

end

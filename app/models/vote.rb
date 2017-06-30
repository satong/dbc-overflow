class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  scope :up, -> { where(direction: "up") }
  scope :down, -> { where(direction: "down") }

  validates :user_id, :uniqueness => {:scope => [:votable_id, :votable_type, :direction]}

  def get_redirect_route
    if self.votable_type == "Question"
      "/questions/#{self.votable.id}"
    elsif self.votable_type == "Answer"
      "/questions/#{self.votable.question_id}"
    elsif self.votable.commentable_type == "Question"
      "/questions/#{self.votable.commentable.id}"
    else
      "/questions/#{self.votable.commentable.question_id}"
    end
  end

end

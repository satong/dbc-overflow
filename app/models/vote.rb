class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  scope :up, -> { where(direction: "up") }
  scope :down, -> { where(direction: "down") }
  scope :vote_number, -> { self.up.count - self.down.count }

  validate :votable_user_check

  def votable_user_check
    errors.add(:user_id, "User cannot vote on own item") if user_id == self.votable.user_id
  end

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

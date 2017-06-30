class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  def answer_preview
    self.body[0..23]
  end

  def get_route
    "/answers/#{self.id}"
  end

  def get_redirect_route
    "/questions/#{self.question.id}"
  end

end

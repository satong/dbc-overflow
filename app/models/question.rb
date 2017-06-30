class Question < ActiveRecord::Base
  belongs_to :user

  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  def time_since_creation
    ((Time.now - created_at) / 3600).round
  end

  def get_route
    "/questions/#{self.id}"
  end

  def get_redirect_route
    get_route
  end

end

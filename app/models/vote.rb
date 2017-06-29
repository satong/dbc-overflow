class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  scope :up, -> { where(direction: "up") }
  scope :down, -> { where(direction: "down") }

  # validates :user_id, :uniqueness => {:scope => [:votable_id, :votable_type]}
end

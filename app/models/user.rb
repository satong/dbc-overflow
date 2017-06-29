class User < ActiveRecord::Base
  include BCrypt
  
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes

  validates :check_password, presence: { message: "- password must not be blank" }
  validates :username, presence: { message: "- username must not be blank" } , uniqueness: { message: "- username must be unique" }
  validates :email, presence: { message: "- email must not be blank" }, uniqueness: { message: "- email must be unique" }


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def check_password
    return true if @password != ""
  end

  def create
    @user = User.new(params[:user])
    @user.password = params[:password] if check_password
    @user.save!
  end

end

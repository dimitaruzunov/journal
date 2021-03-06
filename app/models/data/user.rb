class User
  include Mongoid::Document
  include BCrypt

  field :email, type: String
  field :password_hash, type: String
  has_many :lists
  has_many :todo_lists, class_name: 'TodoListData'
  has_many :repeat_todos

  index({email: 1}, {unique: true, name: 'email_index'})

  validates_presence_of :email, message: 'Email address is required'
  validates_uniqueness_of :email, message: 'Email address exists'
  validates_length_of :password, minimum: 8,
    message: 'Password must be longer than 8 characters'

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.find_by_email(email)
    find_by(email: email)
  end
end

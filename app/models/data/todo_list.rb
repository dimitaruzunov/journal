class TodoListData
  include Mongoid::Document

  store_in collection: 'todo_lists'

  field :date, type: Date
  embeds_many :todos
  belongs_to :user

  index({user_id: 1, date: 1}, {unique: true})

  def self.find_by_date(date, user_id)
    find_or_create_by(date: date, user_id: user_id)
  end
end

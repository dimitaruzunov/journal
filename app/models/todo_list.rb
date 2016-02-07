class TodoList
  include Mongoid::Document

  field :date, type: Date
  embeds_many :todos
  belongs_to :user

  index({user_id: 1, date: 1}, {unique: true})

  def add(text, hour, minute)
    schedule_date = DateTime.new(date.year, date.mon, date.day, hour, minute)
    todos << Todo.new(text: text, date: schedule_date)
  end

  def remove(todo_id)
    todo = todos.find(todo_id)
    todos.delete(todo) if todo
  end

  def done_todos
    todos.select { |todo| todo.done }
  end

  def undone_todos
    todos.reject { |todo| todo.done }
  end

  class << self
    def find_by_date(date, user_id)
      find_or_create_by(date: date, user_id: user_id)
    end

    def find_by_id(id, user_id)
      where(id: id, user_id: user_id).first
    end
  end
end

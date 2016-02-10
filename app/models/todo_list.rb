class TodoList
  include Mongoid::Document

  field :date, type: Date
  embeds_many :todos
  belongs_to :user

  index({user_id: 1, date: 1}, {unique: true})

  def add(text, hour, minute)
    time = Time.new(date.year, date.mon, date.day, hour, minute)
    todos << Todo.new(text: text, time: time)
  end

  def find_by_id(todo_id)
    todos.find(todo_id)
  end

  def remove(todo_id)
    todo = todos.find(todo_id)
    todos.delete(todo) if todo
  end

  def completed_todos
    todos.select { |todo| todo.done }
  end

  def active_todos
    todos.reject { |todo| todo.done }
  end

  def self.find_by_date(date, user_id)
    find_or_create_by(date: date, user_id: user_id)
  end
end

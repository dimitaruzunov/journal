class TodoList
  attr_accessor :date, :todos

  def initialize(todo_list, date, todos)
    @todo_list = todo_list
    @date = date
    @todos = todos
  end

  def find_by_id(todo_id)
    @todo_list.todos.find(todo_id)
  end

  def add(text, time, repeat = nil)
    todo = Todo.new(text: text, time: time)

    if repeat
      repeat_todo = RepeatTodo.add(text, time, repeat, @todo_list.user_id)
      todo.repeat_id = repeat_todo.id
    end

    @todo_list.todos << todo
  end

  def remove(todo_id)
    todo = find_by_id(todo_id)

    RepeatTodo.find(todo.repeat_id).remove if todo.repeat_id

    @todo_list.todos.delete(todo)
  end

  def completed_todos
    todos.select(&:done)
  end

  def active_todos
    todos.reject(&:done)
  end

  def self.find_by_date(date, user_id)
    todo_list = TodoListData.find_or_create_by(date: date, user_id: user_id)
    repeat_todos = RepeatTodo.find_all_by_date(date, user_id)

    date = Date.parse(date)
    repeated = todo_list.todos.select(&:repeat?)

    repeat_todos.each do |repeat_todo|
      next unless repeated.all? { |todo| todo.repeat_id != repeat_todo.id.to_s }

      hour = repeat_todo.time.hour
      minute = repeat_todo.time.min
      time = Time.new(date.year, date.month, date.day, hour, minute)
      id = repeat_todo.id

      new_todo = Todo.new(text: repeat_todo.text, time: time, repeat_id: id)
      todo_list.todos << new_todo
    end

    new(todo_list, date, todo_list.todos)
  end

  def self.unset_repeat(repeat_todo_id)
    todo_lists = TodoListData.where(:'todos.repeat_id' => repeat_todo_id)
    todo_lists.each do |todo_list|
      repeat_todo = todo_list.todos.where(repeat_id: repeat_todo_id).first
      repeat_todo.unset(:repeat_id)
    end
  end
end

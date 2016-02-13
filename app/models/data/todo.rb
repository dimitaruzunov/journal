class Todo
  include Mongoid::Document

  field :text, type: String
  field :done, type: Boolean
  field :time, type: Time
  field :repeat_id, type: String
  embedded_in :todo_list

  def toggle_done
    update_attribute(:done, !done)
  end

  def update(text, time, repeat = nil, user_id = nil)
    if repeat?
      repeat_todo = RepeatTodo.find(repeat_id)
      repeat ? repeat_todo.update(text, time, repeat) : repeat_todo.remove
    elsif repeat
      repeat_todo = RepeatTodo.add(text, time, repeat, user_id)
      repeat_id = repeat_todo.id
    end

    update_attributes(text: text, time: time)
  end

  def repeat?
    repeat_id
  end

  def repeat_string
    RepeatTodo.find(repeat_id).repeat
  end
end

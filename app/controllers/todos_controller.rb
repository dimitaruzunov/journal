class TodosController < ApplicationController
  helpers DayHelpers

  get '/:date/todos/active', auth: true do |date|
    todos = TodoList.find_by_date(date, user_id).active_todos

    render_index todos: todos, date: date
  end

  get '/:date/todos/completed', auth: true do |date|
    todos = TodoList.find_by_date(date, user_id).completed_todos

    render_index todos: todos, date: date
  end
  
  post '/:date/todos', auth: true do |date|
    time = Time.now
    hour = params[:hour] || time.hour
    min = params[:min] || time.min

    todo_list = TodoList.find_by_date(date, user_id)
    todo_list.add(params[:text], hour, min)

    redirect to "/#{date}"
  end

  get '/:date/todos/:id/edit', auth: true do |date, id|
    todo_list = TodoList.find_by_date(date, user_id)
    @todo = todo_list.find_by_id(id)
    @date = date
    slim :'day/edit_todo'
  end

  put '/:date/todos/:id', auth: true do |date, id|
    todo_list = TodoList.find_by_date(date, user_id)
    todo = todo_list.find_by_id(id)
    if not todo
      todo = RepeatTodo.find_by_id(id)
    end

    todo.update(params[:text], params[:hour], params[:min])
  end

  put '/:date/todos/complete/:id', auth: true do |date, id|
    todo_list = TodoList.find_by_date(date, user_id)
    todo = todo_list.find_by_id(id)
    todo.toggle_done

    redirect to "/#{date}"
  end

  delete '/:date/todos/:id', auth: true do |date, id|
    todo_list = TodoList.find_by_date(date, user_id)
    todo_list.remove(id)

    redirect to "/#{date}"
  end
end

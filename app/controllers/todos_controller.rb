class TodosController < ApplicationController
  helpers DayHelpers

  before '/:date/*' do |date, *|
    redirect to '/' unless valid_date? date
  end

  get '/:date/todos/active', auth: true do |date|
    todos = TodoList.find_by_date(date, user_id).active_todos

    render_index todos: todos, date: date
  end

  get '/:date/todos/completed', auth: true do |date|
    todos = TodoList.find_by_date(date, user_id).completed_todos

    render_index todos: todos, date: date
  end
  
  post '/:date/todos', auth: true do |date|
    todo_list = TodoList.find_by_date(date, user_id)

    if params[:repeat] and params[:count]
      repeat = {count: params[:count], type: params[:type]}
      todo_list.add(params[:text], get_time(date, params), repeat)
    else
      todo_list.add(params[:text], get_time(date, params))
    end

    redirect to "/#{date}"
  end

  get '/:date/todos/:id/edit', auth: true do |date, id|
    todo_list = TodoList.find_by_date(date, user_id)
    @todo = todo_list.find_by_id(id)
    @repeat = to_repeat_hash(@todo.repeat_string) if @todo.repeat?
    @date = date
    slim :'day/edit_todo'
  end

  put '/:date/todos/:id', auth: true do |date, id|
    todo_list = TodoList.find_by_date(date, user_id)
    todo = todo_list.find_by_id(id)

    if params[:repeat] and params[:count]
      repeat = {count: params[:count], type: params[:type]}
      todo.update(params[:text], get_time(date, params), repeat, user_id)
    else
      todo.update(params[:text], get_time(date, params))
    end

    redirect to "/#{date}"
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

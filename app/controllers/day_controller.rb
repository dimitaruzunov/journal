class DayController < ApplicationController
  helpers DayHelpers

  get '/:date?', auth: true do |date_string|
    @date_string = date_string || Date.today.to_s

    redirect to '/' if not valid_date?(@date_string)

    date = Date.parse(@date_string)

    @todos = TodoList.find_by_date(date, user_id).todos
    @lists = List.find_by_date(date, user_id)

    slim :'day/index'
  end

  get '/:date/todos/active' do |date|
    redirect to '/' if not valid_date?(date)

    @date_string = date
    @todos = TodoList.find_by_date(date, user_id).active_todos
    @lists = List.find_by_date(date, user_id)

    slim :'day/index'
  end

  get '/:date/todos/completed' do |date|
    redirect to '/' if not valid_date?(date)

    @date_string = date
    @todos = TodoList.find_by_date(date, user_id).completed_todos
    @lists = List.find_by_date(date, user_id)

    slim :'day/index'
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

  post '/:date/list', auth: true do |date|
    List.create_empty(params[:title], date, user_id)
  end

  delete '/:date/list/:id', auth: true do |date, id|
    List.delete_by_id(id, user_id)
  end

  post '/:date/list/:id', auth: true do |date, id|
    list = List.find_by_id(id, user_id)
    list.add(params[:text]) if list
  end

  delete '/:date/list/:id/:item_id', auth: true do |date, list_id, item_id|
    list = List.find_by_id(list_id, user_id)
    list.remove(item_id) if list
  end

  after '/:date/list*' do |date, *|
    redirect to "/#{date}"
  end
end

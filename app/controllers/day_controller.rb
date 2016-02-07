class DayController < ApplicationController
  get '/:date?', authentication: true do |date_string|
    @date_string = date_string || Date.today.to_s
    date = Date.parse(@date_string)

    @todo_list = TodoList.find_by_date(date, user_id)
    @lists = List.find_by_date(date, user_id)

    slim :'day/index'
  end
  
  post '/:date/todos', authentication: true do |date|
    time = Time.now

    @todo_list ||= TodoList.find_by_date(date, user_id)
    @todo_list.add(params[:text], time.hour, time.min)
  end

  post '/:date/list', authentication: true do |date|
    List.create_empty(params[:title], date, user_id)
  end

  delete '/:date/list/:id', authentication: true do |date, id|
    List.delete_by_id(id, user_id)
  end

  post '/:date/list/:id', authentication: true do |date, id|
    list = List.find_by_id(id, user_id)
    list.add(params[:text]) if list
  end

  delete '/:date/list/:id/:item_id', authentication: true do |date, list_id, item_id|
    list = List.find_by_id(list_id, user_id)
    list.remove(item_id) if list
  end

  after '/:date/*' do |date, *|
    redirect to "/#{date}"
  end
end

class ListController < ApplicationController
  helpers DayHelpers

  before '/:date/*' do |date, *|
    redirect to '/' if not valid_date? date
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

  after '/:date/*' do |date, *|
    redirect to "/#{date}"
  end
end

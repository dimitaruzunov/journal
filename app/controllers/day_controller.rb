class DayController < ApplicationController
  helpers DayHelpers

  get '/:date?', auth: true do |date|
    date ||= Date.today.to_s
    redirect to '/' if not valid_date? date

    todos = TodoList.find_by_date(date, user_id).todos

    render_index todos: todos, date: date
  end
end

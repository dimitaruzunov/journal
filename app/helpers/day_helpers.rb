module DayHelpers
  def valid_date?(date_string)
    year, month, day = date_string.split('-').map(&:to_i)
    Date.valid_date? year, month, day if year and month and day
  end

  def render_index(todos:, date:)
    @date = date
    @todos = todos
    @lists = List.find_by_date(date, user_id)

    slim :'day/index'
  end
end

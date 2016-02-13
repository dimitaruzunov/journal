module DayHelpers
  def valid_date?(date_string)
    year, month, day = date_string.split('-').map(&:to_i)
    Date.valid_date? year, month, day if year and month and day
  end

  def get_time(date_string, params)
    now = Time.now
    hour = params[:hour] || now.hour
    min = params[:min] || now.min
    date = Date.parse(date_string)

    Time.new(date.year, date.month, date.day, hour, min)
  end

  def to_repeat_hash(repeat_string)
    matched = repeat_string.match /(\d+)([dw])/
    {count: matched[1].to_i, type: matched[2]}
  end

  def render_index(todos:, date:)
    @date = date
    @todos = todos
    @lists = List.find_by_date(date, user_id)

    slim :'day/index'
  end
end

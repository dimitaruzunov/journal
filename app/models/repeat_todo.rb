class RepeatTodo
  include Mongoid::Document

  field :text, type: String
  field :done, type: Boolean
  field :time, type: Time
  field :repeat, type: String
  belongs_to :user

  class << self
    def add(text, time, repeat, user_id)
      create(text: text, time: time, repeat: repeat, user_id: user_id)
    end

    def find_all_by_date(date_string, user_id)
      date = Date.parse(date_string)

      repeat_todos = where(:time.lte => date_string, user_id: user_id)
      repeat_todos.select do |todo|
        day_difference = date - time_to_date(todo.time)
        day_difference % repeat_count(todo) == 0
      end
    end

    private

    def time_to_date(time)
      Date.new(time.year, time.month, time.day)
    end

    def repeat_count(todo)
      count = todo.repeat.match(/\d+/)[0].to_i
      case todo.repeat
        when /d/ then count
        when /w/ then count * 7
      end
    end
  end
end

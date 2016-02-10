class Todo < Item
  include Mongoid::Document

  field :done, type: Boolean
  field :time, type: Time
  embedded_in :todo_list

  def toggle_done
    update_attribute(:done, !done)
  end

  def update(text, hour, min)
    updated_time = Time.new(time.year, time.month, time.day, hour, min)
    update_attributes(text: text, time: updated_time)
  end
end

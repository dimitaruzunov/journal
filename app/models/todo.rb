class Todo < Item
  include Mongoid::Document

  field :done, type: Boolean
  field :date, type: DateTime
  embedded_in :todo_list
end

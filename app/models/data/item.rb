class Item
  include Mongoid::Document

  field :text, type: String
  embedded_in :list
end

class ListItemData
  include Mongoid::Document

  field :text, type: String
  embedded_in :list, class_name: 'ListData', inverse_of: :items
end

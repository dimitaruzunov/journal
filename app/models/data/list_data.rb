class ListData
  include Mongoid::Document

  store_in collection: 'lists'

  field :title, type: String
  field :date, type: Date
  embeds_many :items, class_name: 'ListItemData', inverse_of: :list
end

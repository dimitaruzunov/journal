class List
  include Mongoid::Document

  field :title, type: String
  field :date, type: Date
  embeds_many :items
  belongs_to :user, index: true

  def add(text)
    items << Item.new(text: text)
  end

  def remove(item_id)
    item = items.find(item_id)
    items.delete(item) if item
  end

  class << self
    def create_empty(title, date, user_id)
      create(title: title, date: date, user_id: user_id)
    end

    def find_by_date(date, user_id)
      where(date: date, user_id: user_id)
    end

    def find_by_id(id, user_id)
      where(id: id, user_id: user_id).first
    end

    def delete_by_id(id, user_id)
      found_list = find_by_id(id, user_id)
      found_list.delete if found_list
    end
  end
end

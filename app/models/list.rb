class List
  class Item
    attr_accessor :text

    def initialize(text)
      @text = text
    end
  end

  include Enumerable

  attr_accessor :title, :date

  def initialize(title, date, items = [])
    @title = title
    @date = date
    @items = items
  end

  def each
    @items.each(&proc)
  end

  def add(item)
    @items << item
  end

  def remove(item)
    @items.delete(item)
  end
end

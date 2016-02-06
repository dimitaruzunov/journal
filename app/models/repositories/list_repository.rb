module ListRepository
  extend self

  def find_by_date(date)
    ListData.where(date: date)
  end

  def create_empty(title, date)
    ListData.create(title: title, date: date)
  end
end

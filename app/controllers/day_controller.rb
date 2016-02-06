class DayController < ApplicationController
  get '/:date?', authentication: true do
    @date_string = params[:date] || Date.today.to_s
    date = Date.parse(@date_string)
    @lists = ListRepository.find_by_date(date)

    slim :'day/day'
  end

  post '/:date/list', authentication: true do
    ListRepository.create_empty(params[:title], params[:date])
  end

  private

  def get_date(params)
    date_string = params[:date] || Date.today.to_s
    Date.parse(date_string)
  end
end

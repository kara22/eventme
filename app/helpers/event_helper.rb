module EventHelper
  def number_of_days(event)
    (event.start_time.to_date - Date.today).to_i
  end
end

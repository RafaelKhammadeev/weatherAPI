module Weather
  class TimeAnalyzer
    def initialize(time, forecast_by_hour)
      @time = time
      @forecast_by_hour = forecast_by_hour
    end

    def valid_time?
      return false unless @time

      upper_limit = @forecast_by_hour.first[:time]
      lower_limit = @forecast_by_hour.last[:time]

      !(upper_limit < @time || lower_limit > @time)
    end

    def find_near_time
      differents = @forecast_by_hour.map { |hist_by_hour| (@time - hist_by_hour[:time]).abs }
      nearest_elem_ind = differents.find_index(differents.min)
      @forecast_by_hour[nearest_elem_ind]
    end
  end
end

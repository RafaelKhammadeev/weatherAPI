module Weather
  class Adapter
    delegate :fetch_current_conditions_historical, :fetch_current_conditions, to: :client

    def fetch_daily_forecast_by_metric
      client.fetch_daily_forecast(metric: "true")
    end

    def fetch_historical
      response = client.fetch_current_conditions_historical

      historical = []
      response.each { |hour_hist| historical << prepare_current_conditions_params(hour_hist) }
      historical
    end

    private

    def client
      @client ||= Weather::Client.new
    end

    def prepare_current_conditions_params(hour_hist)
      {
        time: hour_hist["EpochTime"],
        temperature: hour_hist["Temperature"]["Metric"]["Value"]
      }
    end
  end
end

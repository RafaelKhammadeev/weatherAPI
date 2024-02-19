module Weather
  class Adapter
    delegate :fetch_current_conditions_historical, :fetch_current_conditions, to: :client

    def daily_forecast_by_metric
      client.fetch_daily_forecast(metric: "true")
    end

    private

    def client
      @client = Weather::Client.new
    end
  end
end
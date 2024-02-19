module Weather
  class Client
    include HTTParty
    base_uri "https://dataservice.accuweather.com"

    def initialize
      @apikey = ENV.fetch("API_Key", nil)
      @town_id = ENV.fetch("Town_ID", nil)
    end

    def fetch_daily_forecast(query = {})
      self.class.get("/forecasts/v1/daily/1day/#{@town_id}", query: query_prepare(query))
    end

    def fetch_current_conditions_historical
      self.class.get("/currentconditions/v1/#{@town_id}/historical/24", query: hashed_apikey)
    end

    def fetch_current_conditions
      self.class.get("/currentconditions/v1/#{@town_id}", query: hashed_apikey)
    end

    private

    def hashed_apikey
      { apikey: @apikey }
    end

    def query_prepare(query)
      query.reverse_merge!(hashed_apikey)
    end
  end
end

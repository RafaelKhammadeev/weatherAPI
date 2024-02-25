require "rails_helper"

RSpec.describe Weather::Adapter do
  let(:weather_adapter) { described_class.new }
  let(:base_url) { "https://dataservice.accuweather.com" }
  let(:town_id) { ENV.fetch("Town_ID") }
  let(:hashed_apikey) { { apikey: ENV.fetch("API_Key") } }

  it "#fetch_daily_forecast_by_metric" do
    url = "#{base_url}/forecasts/v1/daily/1day/#{town_id}"
    query = hashed_apikey.merge({ metric: "true" })
    stub_request(:get, url).with(query:).to_return(status: 200)

    weather_adapter.fetch_daily_forecast_by_metric
    expect(WebMock).to have_requested(:get, url).with(query:)
  end
end

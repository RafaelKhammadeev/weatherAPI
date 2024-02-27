require "rails_helper"

RSpec.describe Weather::Client do
  let(:weather_client) { described_class.new }
  let(:base_url) { "https://dataservice.accuweather.com" }
  let(:town_id) { ENV.fetch("Town_ID") }
  let(:hashed_apikey) { { apikey: ENV.fetch("API_Key") } }

  it "#fetch_daily_forecast" do
    url = "#{base_url}/forecasts/v1/daily/1day/#{town_id}"
    stub_request(:get, url).with(query: hashed_apikey).to_return(status: 200)

    weather_client.fetch_daily_forecast
    expect(WebMock).to have_requested(:get, url).with(query: hashed_apikey)
  end

  it "#fetch_current_conditions_historical" do
    url = "#{base_url}/currentconditions/v1/#{town_id}/historical/24"
    stub_request(:get, url).with(query: hashed_apikey).to_return(status: 200)

    weather_client.fetch_current_conditions_historical
    expect(WebMock).to have_requested(:get, url).with(query: hashed_apikey)
  end

  it "#fetch_current_conditions" do
    url = "#{base_url}/currentconditions/v1/#{town_id}"
    stub_request(:get, url).with(query: hashed_apikey).to_return(status: 200)

    weather_client.fetch_current_conditions
    expect(WebMock).to have_requested(:get, url).with(query: hashed_apikey)
  end
end

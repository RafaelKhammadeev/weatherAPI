module API
  module V1
    module Weather
      class HistoricalController < ApplicationController
        before_action :basic_response

        def max
          maximum_temperature = session["weather"]["maximum_temperature"]
          render json: { maximum_temperature: }
        end

        def min
          minimum_temperature = session["weather"]["minimum_temperature"]
          render json: { minimum_temperature: }
        end

        def avg
          average_temperature = session["weather"]["average_temperature"]
          render json: { average_temperature: }
        end

        private 

        def basic_response
          return if session.key?("weather") && session["weather"]["synchronization_time"] > Date.today.to_s

          response = HTTParty.get("http://dataservice.accuweather.com/forecasts/v1/daily/1day/295954?apikey=#{ENV["API_Key"]}&metric=true")
          
          temperature = response["DailyForecasts"].first["Temperature"]

          maximum_temperature = temperature["Maximum"]["Value"]
          minimum_temperature = temperature["Minimum"]["Value"]
          average_temperature = (maximum_temperature + minimum_temperature) / 2

          session["weather"] = {
            synchronization_time: Date.tomorrow.to_s,
            maximum_temperature:,
            minimum_temperature:,
            average_temperature:
          }
        end
      end
    end
  end
end

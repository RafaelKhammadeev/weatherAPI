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

        def weather_adapter
          ::Weather::Adapter.new
        end

        def basic_response
          return if session.key?("weather") && session["weather"]["synchronization_time"] > Date.today.to_s

          # Нужно добавить ошибку, если количество запросов привышено
          # Они вроде генерируются, если правильно помню
          response = weather_adapter.daily_forecast_by_metric
          
          temperature = response["DailyForecasts"].first["Temperature"]

          maximum_temperature = temperature["Maximum"]["Value"]
          minimum_temperature = temperature["Minimum"]["Value"]
          average_temperature = (maximum_temperature + minimum_temperature) / 2

          session["weather"] = {
            synchronization_time: Date.tomorrow,
            maximum_temperature:,
            minimum_temperature:,
            average_temperature:
          }
        end
      end
    end
  end
end

module API
  module V1
    module Weather
      class HistoricalController < ApplicationController
        before_action :basic_response

        def max
          maximum_temperature = session[:weather][:max_temp]
          render json: { maximum_temperature: }
        end

        def min
          minimum_temperature = session[:weather][:min_temp]
          render json: { minimum_temperature: }
        end

        def avg
          average_temperature = session[:weather][:avg_temp]
          render json: { average_temperature: }
        end

        private

        def weather_adapter
          ::Weather::Adapter.new
        end

        def basic_response
          return if session.key?("weather") && session["weather"]["sync_time"] > Time.zone.today.to_s

          # Нужно добавить ошибку, если количество запросов привышено
          # Они вроде генерируются, если правильно помню
          response = weather_adapter.fetch_historical
          temperatures = response.pluck(:temperature)
          # по идее можно делать проверку если прошел час, то обновлять данные в куки:D

          session["weather"] = {
            sync_time: Time.zone.today,
            max_temp: temperatures.max,
            min_temp: temperatures.min,
            avg_temp: (temperatures.sum / temperatures.size).round(2)
          }
        end
      end
    end
  end
end

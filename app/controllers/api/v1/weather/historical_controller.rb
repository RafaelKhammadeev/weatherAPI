module API
  module V1
    module Weather
      class HistoricalController < ApplicationController
        before_action :basic_response
        
        # подумать, где можно хранить данные, чтоб не делать много запросов
        def max
          response = HTTParty.get("http://dataservice.accuweather.com/forecasts/v1/daily/1day/295954?apikey=#{ENV["API_Key"]}&metric=true")

          maximum_temperature = response["DailyForecasts"].first["Temperature"]["Maximum"]["Value"]
          render json: { maximum_temperature: }
        end

        def min
          response = HTTParty.get("http://dataservice.accuweather.com/forecasts/v1/daily/1day/295954?apikey=#{ENV["API_Key"]}&metric=true")

          minimum_temperature = response["DailyForecasts"].first["Temperature"]["Minimum"]["Value"]
          render json: { minimum_temperature: }
        end

        def avg
          response = HTTParty.get("http://dataservice.accuweather.com/forecasts/v1/daily/1day/295954?apikey=#{ENV["API_Key"]}&metric=true")

          maximum_temperature = response["DailyForecasts"].first["Temperature"]["Maximum"]["Value"]
          minimum_temperature = response["DailyForecasts"].first["Temperature"]["Minimum"]["Value"]

          average_temperature = (maximum_temperature + minimum_temperature) / 2
          render json: { average_temperature: }
        end

        private 
        # Можно вынести все запросы в один метод и использовать в before action, как раз таки там можно
        # будет сделать все проверки на куки (это тоже нужно будет подумать:D)
        def basic_response
          response = HTTParty.get("http://dataservice.accuweather.com/forecasts/v1/daily/1day/295954?apikey=#{ENV["API_Key"]}&metric=true")
          temperature = response["DailyForecasts"].first["Temperature"]

          maximum_temperature = temperature["Maximum"]["Value"]
          minimum_temperature = temperature["Minimum"]["Value"]
          average_temperature = (maximum_temperature + minimum_temperature) / 2

          cookies
        end
      end
    end
  end
end

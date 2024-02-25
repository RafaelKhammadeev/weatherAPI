module API
  module V1
    class WeatherController < ApplicationController
      def current
        response = weather_adapter.fetch_current_conditions
        parsed_response = JSON.parse(response.body).first

        current_temperature = parsed_response["Temperature"]["Metric"]["Value"].to_s
        render json: { current_temperature: }
      end

      def by_time
        historical = weather_adapter.fetch_historical
        weather_time_analyzer = ::Weather::TimeAnalyzer.new(fetch_time, historical)

        if weather_time_analyzer.valid_time?
          near_measure = weather_time_analyzer.find_near_time

          render json: { temperature: near_measure[:temperature] }
        else
          render json: { error: 404 }
        end
      end

      private

      def weather_adapter
        @weather_adapter ||= ::Weather::Adapter.new
      end

      def fetch_time
        time = /\d{10}/.match(params[:time])
        time = time[0].to_i if time
      end
    end
  end
end

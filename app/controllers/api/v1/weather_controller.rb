module API
  module V1
    class WeatherController < ApplicationController
      before_action :fetch_time, only: %i[by_time]
      before_action :fetch_historical, only: %i[by_time]

      def current
        response = weather_adapter.fetch_current_conditions
        parsed_response = JSON.parse(response.body).first

        current_temperature = parsed_response["Temperature"]["Metric"]["Value"].to_s
        render json: { current_temperature: }
      end

      def by_time
        if valid_time?(@time, @historical)
          near_measure = near_time(@time, @historical)

          render json: { temperature: near_measure[:temperature] }
        else
          render json: { error: 404 }
        end
      end

      private

      def fetch_time
        @time = /\d{10}/.match(params[:time])
        @time = @time[0].to_i if @time
      end

      def weather_adapter
        ::Weather::Adapter.new
      end

      def fetch_historical
        response = weather_adapter.fetch_current_conditions_historical

        @historical = []
        response.each do |hour_historical|
          @historical << {
            time: hour_historical["EpochTime"],
            temperature: hour_historical["Temperature"]["Metric"]["Value"]
          }
        end
      end

      def valid_time?(time, historical)
        return false unless time

        upper_limit = historical.first[:time]
        lower_limit = historical.last[:time]

        !(upper_limit < time || lower_limit > time)
      end

      def near_time(time, historical)
        max_index = historical.size
        mid_index = max_index / 2

        if max_index == 2
          first_diff = time - historical.first[:time].abs
          second_diff = time - historical.last[:time].abs

          result = first_diff > second_diff ? historical.last : historical.first
          return result
        end

        center_measurement = historical[mid_index][:time]
        if time > center_measurement
          near_time(time, historical[0..(mid_index - 1)])
        else
          near_time(time, historical[(mid_index + 1)..max_index])
        end
      end
    end
  end
end

module API
  module V1
    class WeatherController < ApplicationController
      before_action :get_time, only: %i[by_time]
      before_action :get_historical, only: %i[by_time]

      def current
        response = HTTParty.get("http://dataservice.accuweather.com/currentconditions/v1/295954?apikey=#{ENV["API_Key"]}")
        parsed_response = JSON.parse(response.body).first
        
        current_temperature = parsed_response['Temperature']['Metric']['Value'].to_s
        render json: { current_temperature:  }
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

      def get_time
        @time = /\d{10}/.match(params[:time])
        @time = @time[0].to_i if @time
      end

      def get_historical
        response = HTTParty.get("http://dataservice.accuweather.com/currentconditions/v1/295954/historical/24?apikey=#{ENV["API_Key"]}")

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
          first_diff = time - (historical.first[:time]).abs
          second_diff = time - (historical.last[:time]).abs

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
module API
  module V1
    class WeatherController < ApplicationController
      def current
        response = HTTParty.get("http://dataservice.accuweather.com/currentconditions/v1/295954?apikey=#{ENV["API_Key"]}")
        parsed_response = JSON.parse(response.body).first
        
        current_temperature = parsed_response['Temperature']['Metric']['Value'].to_s
        render json: { current_temperature:  }
      end

      def by_time
        render json: { online: "by time" }
      end
    end
  end
end
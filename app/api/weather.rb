module Weather
  class API < Grape::API


    format :json
    version "v1"

    # base_uri 'http://dataservice.accuweather.com'

    # AREA = "295954" # Kazan

    resource :weather do
      get :current do
        response = HTTParty.get("http://dataservice.accuweather.com/currentconditions/v1/295954?apikey=HZx6OsztXRnGnnGkugN99iXj9aStELOX")

        # response.body

        # {
        #   current_temperature: response['Temperature']['Metric']['Value']
        # }
      end
    end
  end
end

module API
  module V1
    module Weather
      class ByTimesController < API::V1::Weather::APIController
        def show
          render json: { online: "by time" }
        end
      end
    end
  end
end

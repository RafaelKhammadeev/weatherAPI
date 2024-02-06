module API
  module V1
    module Weather
      class CurrentsController < API::V1::Weather::APIController
        def show
          render json: { online: "current" }
        end
      end
    end
  end
end

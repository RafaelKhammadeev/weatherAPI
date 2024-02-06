module API
  module V1
    module Weather
      module Hisorical
        class MaxsController < API::V1::Weather::APIController
          def show
            render json: { online: "max" }
          end
        end
      end
    end
  end
end

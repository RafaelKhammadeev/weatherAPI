module API
  module V1
    module Weather
      module Hisorical
        class MinsController < API::V1::Weather::APIController
          def show
            render json: { online: "min" }
          end
        end
      end
    end
  end
end

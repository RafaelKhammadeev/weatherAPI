module API
  module V1
    module Weather
      module Hisorical
        class AvgsController < API::V1::Weather::APIController
          def show
            render json: { online: "avg" }
          end
        end
      end
    end
  end
end

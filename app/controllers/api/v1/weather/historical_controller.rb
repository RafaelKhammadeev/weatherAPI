module API
  module V1
    module Weather
      class HistoricalController < ApplicationController
        def max
          render json: { online: "max" }
        end

        def min
          render json: { online: "min" }
        end

        def avg
          render json: { online: "avg" }
        end
      end
    end
  end
end

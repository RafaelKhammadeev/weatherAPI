module API
  module V1
    class HealthsController < ApplicationController
      def show
        render json: { online: "health" }
      end
    end
  end
end
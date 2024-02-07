module API
  module V1
    class HealthController < ApplicationController
      def status
        render json: { status: "Ок" }
      end
    end
  end
end
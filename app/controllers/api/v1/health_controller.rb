module API
  module V1
    class HealthController < ApplicationController
      def status
        render json: { status: "ok" }
      end
    end
  end
end

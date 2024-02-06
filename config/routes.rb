Rails.application.routes.draw do
  # grape
  # mount Weather::API => '/'

  namespace :api do
    namespace :v1, defaults: { format: :json }  do
      resource :health, only: %i[show]


      namespace :weather do
        namespace :hisorical do
          resource :max, only: %i[show]
          resource :min, only: %i[show]
          resource :avg, only: %i[show]
        end

        resource :by_time, only: %i[show]
      end
    end
  end
end

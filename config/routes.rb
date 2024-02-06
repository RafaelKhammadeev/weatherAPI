Rails.application.routes.draw do
  mount Root => '/'

  namespase :api do
    namespase :v1, defaults: { format: :json }  do
      resource :health, only: %i[show]


      namespase :weather do
        namespase :hisorical do
          resource :max, only: %i[show]
          resource :min, only: %i[show]
          resource :avg, only: %i[show]
        end

        resource :by_time, only: %i[show]
      end
    end
  end
end

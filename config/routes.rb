Rails.application.routes.draw do
  # grape
  # mount Weather::API => '/'

  namespace :api do
    namespace :v1, defaults: { format: :json }  do
      get :health, to: "health#status"

      scope "/weather" do
        get :current, to: "weather#current"
        get :by_time, to: "weather#by_time"
      end
      
      namespace :weather do
        scope "/historical" do
          get :max, to: "historical#max"
          get :min, to: "historical#min"
          get :avg, to: "historical#avg"
        end
      end
    end
  end
end

class Root < Grape::API
  prefix :grape
  mount Weather::API
end
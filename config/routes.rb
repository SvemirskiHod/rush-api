Rails.application.routes.draw do
  get '/players', to: 'players#index'
end

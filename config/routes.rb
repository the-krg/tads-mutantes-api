Rails.application.routes.draw do

  resources :mutants

  resources :powers do
    get '/mutants', to: 'powers#mutants'
  end

  resources :users
  post '/login', to: 'users#login'

  get '/mutants_by_power', to: 'powers#mutants_by_power'
end

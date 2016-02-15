Rails.application.routes.draw do
  get 'coins/index'

  get 'coins/show'

  devise_for :users, :controllers => {sessions: 'sessions',
                                      registrations: 'registrations'} 
  root 'persons#profile'
  get 'persons/profile', as: 'user_root'
   
  get '/coins/coin_information/:coin_id', to: 'coins#coin_information', as: 'coin_information'
  get '/coins/coin_add/:coin_id', to: 'coins#coin_add', as: 'coin_add'
  
end

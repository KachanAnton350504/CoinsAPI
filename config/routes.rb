Rails.application.routes.draw do
  get 'coins/index'

  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}, 
                     :skip => [:registrations]
  as :user do
    post 'users/sign_up' => 'registrations#create', :as => :user_registration
    get   '/users/edit' =>  'registrations#edit', :as => :edit_user_registration
  end
  
  root 'persons#profile'
  get 'persons/profile', as: 'user_root'
   
  


  get '/coins/coin_information/:coin_id', to: 'coins#coin_information', as: 'coin_information'
  get '/coins/coin_add/:coin_id', to: 'coins#coin_add', as: 'coin_add'
  get 'coins/show', to: 'coins#show', as: 'coin_show'
  get '/coins/countries/', to: 'coins#countries', as: 'countries'
  get '/coins/continents/', to: 'coins#continents', as: 'continents'
  get '/coins/coin_sets/', to: 'coins#coin_sets', as: 'coin_sets'
  get '/coins/coins/', to: 'coins#coins', as: 'coins'
  get '/coins/coins_search/', to: 'coins#coins_search', as: 'coins_search'

end

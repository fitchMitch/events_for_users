Rails.application.routes.draw do
  get 'events/search'
  get 'events/date_filter'
  get 'events/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :users, only: %i[index edit update create]
  resources :users, :events, only: [:index]

  get  '/search_by_location'              => 'events#search_by_location'
  get  '/search_by_title_or_description'  => 'events#search_by_title_or_description'
  get  '/date_filter'                     => 'events#date_filter'

  root 'events#index'
end

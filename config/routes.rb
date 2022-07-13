Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations:'registrations',sessions:'sessions'}
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    #get '/prueba' => 'devise/sessions#cruceMethod'
  end
  root "home#homepage" 
  get '/home', to: 'home#homepage', as:'home_page'
  get '/realizedP', to: 'home#realizedP', as:'home_realizedP'
  get '/prueba', to: 'prueba#prueba'
 # get '/users/:documentNumber', to: 'registratons#findPropietario', as: 'users_find_propietario'
  
end

Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations:'registrations',sessions:'sessions'}
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    #get '/prueba' => 'devise/sessions#cruceMethod'
  end
  root "home#homepage" 
  get '/home', to: 'home#homepage', as:'home_page'
  get '/pagosRealizados/:id', to: 'home#realizedP', as:'home_realizedP'
  get '/pagosPendientes/:id', to: 'home#pendingP', as:'home_pendingP'
  get '/realizarPagoPendiente/:id', to: 'home#sendPaymentInfo', as: 'home_sendPayment' 
  #get '/prueba', to: 'prueba#prueba'
 # get '/users/:documentNumber', to: 'registratons#findPropietario', as: 'users_find_propietario'
  
end

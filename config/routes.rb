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
  get '/recibo/:id', to: 'home#recibo', as: 'home_recibo'
  get '/validate/:id', to: 'home#validateExistence', as: 'home_validate'
  get '/pazysalvo/:id', to: 'home#pazSalvo', as: 'home_paz_salvo'
  #get '/prueba', to: 'prueba#prueba'
 # get '/users/:documentNumber', to: 'registratons#findPropietario', as: 'users_find_propietario'
  
end

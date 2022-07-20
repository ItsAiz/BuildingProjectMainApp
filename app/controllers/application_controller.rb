class ApplicationController < ActionController::Base
    before_action :authenticate_user!
   #layout false, only: [:recibo]
end

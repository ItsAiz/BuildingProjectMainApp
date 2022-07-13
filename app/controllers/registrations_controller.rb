class RegistrationsController < Devise::RegistrationsController
    before_action :findPropietario, only: [:create]
    def findPropietario
        begin
            @propietario = Propietario.find(params[:user][:documentNumber])
            if @propietario.Correo != params[:user][:email]
                redirect_to cancel_user_registration_path
            
            end
        rescue => exception
            redirect_to cancel_user_registration_path
        end
    end

    def sign_up_params
        params.require(:user).permit(:email,:password,:password_confirmation,:documentNumber)
    end 
end

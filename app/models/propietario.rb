class Propietario < ApplicationRecord
    belongs_to :user
    #before_create :RegistrationsController.findPropietario
end
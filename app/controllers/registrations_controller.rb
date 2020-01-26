# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController

    protected
    def update_resource(resource, params)
        resource.update_without_password(params)
    end
end
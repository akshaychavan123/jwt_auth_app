# app/controllers/users/registrations_controller.rb

class Users::RegistrationsController < Devise::RegistrationsController
    skip_before_action :authenticate_request, only: [:create]
    respond_to :json
  
    def create
      build_resource(sign_up_params)
  
      if resource.save
        sign_in(resource)
        render json: { user: resource, status: :created }
      else
        render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
  
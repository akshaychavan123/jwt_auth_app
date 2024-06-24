# app/controllers/users/passwords_controller.rb

class Users::PasswordsController < Devise::PasswordsController
    skip_before_action :authenticate_request
    include ActionController::Flash
    respond_to :json
  
    def create
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      if successfully_sent?(resource)
        render json: { message: 'Password reset instructions have been sent to your email.' }, status: :ok
      else
        render json: { errors: ["Email not found"] }, status: :unprocessable_entity
      end
    end
  
    def edit
      set_minimum_password_length
      resource = resource_class.new
      resource.reset_password_token = params[:reset_password_token]
      render json: { reset_password_token: resource.reset_password_token }, status: :ok
    end
  
    def update
      self.resource = resource_class.reset_password_by_token(resource_params)
      if resource.errors.empty?
        render json: { message: 'Password successfully updated.' }, status: :ok
      else
        render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
  
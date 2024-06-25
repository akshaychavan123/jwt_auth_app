# # app/controllers/application_controller.rb

# class ApplicationController < ActionController::API
#     include JsonWebToken
#     before_action :authenticate_request
#     attr_reader :current_user
  
#     private
  
#     def authenticate_request
#       token = request.headers['Authorization']&.split(' ')&.last
#       decoded = jwt_decode(token)
#       @current_user = User.find(decoded[:user_id])
#     rescue ActiveRecord::RecordNotFound, JWT::DecodeError
#       render json: { errors: 'Unauthorized' }, status: :unauthorized
#     end
#   end
  # app/controllers/application_controller.rb

class ApplicationController < ActionController::API
  include JsonWebToken
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    decoded = jwt_decode(token)
    @current_user = User.find(decoded[:user_id])
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end
end

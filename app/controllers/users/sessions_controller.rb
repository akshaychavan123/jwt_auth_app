# # app/controllers/users/sessions_controller.rb

# class Users::SessionsController < Devise::SessionsController
#     respond_to :json
#     skip_before_action :verify_signed_out_user, only: :destroy
#     skip_before_action :authenticate_request, only: [:create]
  
#     def create
#       user = User.find_for_authentication(email: params[:user][:email])
#       if user&.valid_password?(params[:user][:password])
#         sign_in(user)
#         user.update(token: generate_token(user))
#         render json: { id: user.id, token: user.token, success: true }, status: :ok
#       else
#         render json: { error: 'Invalid email or password', success: false }, status: :unauthorized
#       end
#     end
  
#     def destroy
#       token = request.headers['Authorization']&.split(' ')&.last
#       user = User.find_by(token: token)
#       if user
#         user.update!(token: nil)
#         sign_out(user)
#         render json: { message: 'Signed out successfully' }, status: :ok
#       else
#         render json: { error: 'Invalid token', success: false }, status: :unauthorized
#       end
#     end
  
#     private
  
#     def generate_token(user)
#       # at here initialy ENV['SECRET_KEY'] instead we are using Rails.application.secret_key_base
#       JWT.encode({ user_id: user.id }, ENV['SECRET_KEY'])
#     end
#   end
  # app/controllers/users/sessions_controller.rb

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_signed_out_user, only: :destroy
  skip_before_action :authenticate_request, only: [:create]

  def create
    user = User.find_for_authentication(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      sign_in(user)
      token = generate_token(user)
      user.update(token: token)
      render json: { id: user.id, token: token, success: true }, status: :ok
    else
      render json: { error: 'Invalid email or password', success: false }, status: :unauthorized
    end
  end

  def destroy
    token = request.headers['Authorization']&.split(' ')&.last
    user = User.find_by(token: token)
    if user
      user.update!(token: nil)
      sign_out(user)
      render json: { message: 'Signed out successfully' }, status: :ok
    else
      render json: { error: 'Invalid token', success: false }, status: :unauthorized
    end
  end

  private

  def generate_token(user)
    payload = { user_id: user.id, iat: Time.now.to_i }
    jwt_encode(payload)
  end
end

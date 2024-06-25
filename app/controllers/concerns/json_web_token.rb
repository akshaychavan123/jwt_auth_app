# app/controllers/concerns/json_web_token.rb
# module JsonWebToken
# #   setted value of Rails.application.secret_key_base in .env which we are using for encode, decode and genrating token
# # in session controller.
# # at initial get value by debugging here only SECRET_KEY
#     SECRET_KEY = ENV['SECRET_KEY']
  
#     def jwt_encode(payload, exp = 7.days.from_now)
#       payload[:exp] = exp.to_i
#       JWT.encode(payload, SECRET_KEY)
#     end
  
#     def jwt_decode(token)
#       decoded = JWT.decode(token, SECRET_KEY)[0]
#       HashWithIndifferentAccess.new(decoded)
#     end
#   end
  
# app/controllers/concerns/json_web_token.rb

module JsonWebToken
  SECRET_KEY = ENV['SECRET_KEY']

  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  end
end

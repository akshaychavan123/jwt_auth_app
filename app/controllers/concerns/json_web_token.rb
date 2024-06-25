# app/controllers/concerns/json_web_token.rb
module JsonWebToken
    SECRET_KEY = ENV['SECRET_KEY']
  
    def jwt_encode(payload, exp = 7.days.from_now)
      puts SECRET_KEY
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end
  
    def jwt_decode(token)
      puts SECRET_KEY
      decoded = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new(decoded)
    end
  end
  
class JsonWebToken

	#secret to code and decode token
	HMAC_SECRET = Rails.application.secrets.secret_key_base

	def self.encode(payload, exp = 24.hours.from_now)
		# set to expire in 24h
		payload[:exp] = exp.to_i

		# sign token with app secret
		JWT.encode(payload, HMAC_SECRET)
	end

	def self.decode(token)
		# get payload
		body = JWT.decode(token, HMAC_SECRET)[0]
		HashWithIndifferentAccess.new body
		# rescue from all decode errors
	rescue JWT::DecodeError => e
		# raise custom error for exception handler
		raise ExceptionHandler::InvalidToken, e.message
	end

end
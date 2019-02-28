# Error for security issues
# class SecurityError < StandardError; end

# Service for finding a user based on a JWT token
class TokenService
  def initialize(token)
    @token = token
    p "token service called"
  end

  def self.find_user(token:)
    new(token).find_user
  end

  def find_user
    hash = JWT.decode(token, ENV['JWT_KEY'])
    raise SecurityError, 'Invalid token' if hash[0]['email'].nil?
    hash[0]
  rescue JWT::VerificationError, JWT::DecodeError => error
    raise SecurityError, error.message
  end

  private

  attr_reader :token
end

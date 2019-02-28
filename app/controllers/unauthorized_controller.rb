# Failure app for Warden
class UnauthorizedController < ActionController::Metal
  def self.call(env)
    @respond ||= action(:respond)
    @respond.call(env)
  end

  def respond
    self.content_type = 'application/json'
    self.response_body = [{ message: warden_message || 'Unauthorized' }].to_json
    self.status = :unauthorized
  end

  private

  def warden
    request.respond_to?(:get_header) ? request.get_header('warden') : request.env['warden']
  end

  def warden_options
    request.respond_to?(:get_header) ? request.get_header('warden.options') : request.env['warden.options']
  end

  def warden_message
    @warden_message ||= warden.message || warden_options[:message]
  end
end

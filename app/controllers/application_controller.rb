class ApplicationController < ActionController::API
  def authenticate!
    request.env['warden'].authenticate!
  end

  def current_user
    request.env['warden'].user
  end
end

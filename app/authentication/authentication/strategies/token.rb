module Authentication
  module Strategies
    class Token < Warden::Strategies::Base
      def valid?
        access_token.present?
      end

      def authenticate!
        user = TokenService.find_user(token: access_token)
        success!(user)
      rescue SecurityError => error
        fail!(error.message)
      end

      private

      def access_token
        @access_token ||= request.headers['Access-Token']
      end
    end
  end
end

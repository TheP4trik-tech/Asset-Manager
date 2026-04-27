  module Api
    module V1
      class ApiController < ActionController::API

        include ActionController::HttpAuthentication::Token::ControllerMethods
        before_action :authenticate

        private
        def authenticate
          authenticate_or_request_with_http_token do |token, _|
            user = User.find_by(api_key: token)
            if user
              Current.user = user
              user

            else
              false
            end
          end
        end

      end
    end
  end
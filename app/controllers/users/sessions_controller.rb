# frozen_string_literal: true

# app/controllers/users/sessions_controller.rb
module Users
  class SessionsController < Devise::SessionsController
    prepend_before_action :current_user?, only: %i[destroy]

    private

    def current_user?
      error_response('User failed to log out.') if current_user.blank?
    end

    def respond_with(_resource, _opts = {})
      return log_in_success if current_user

      error_response('User failed to log in.')
    end

    def respond_to_on_destroy
      return log_out_success unless current_user

      error_response('User failed to log out.')
    end

    def log_in_success
      @message = 'You are logged in.'
      render :create, status: :ok
    end

    def log_out_success
      @message = 'You are logged out'
      render :destroy, status: :ok
    end

    def error_response(details)
      @error = { message: 'Hmm nothing happened.', details: }
      render 'shared/error', status: :unauthorized
    end
  end
end

# frozen_string_literal: true

# app/controllers/users/sessions_controller.rb
module Users
  class SessionsController < Devise::SessionsController
    private

    def respond_with(_resource, _opts = {})
      @message = 'You are logged in.'
      render :create, status: :ok
    end

    def respond_to_on_destroy
      return log_out_success unless current_user

      log_out_failure
    end

    def log_out_success
      @message = 'You are logged out'
      render :destroy, status: :ok
    end

    def log_out_failure
      @message = 'Hmm nothing happened.'
      render :destroy, status: :unauthorized
    end
  end
end

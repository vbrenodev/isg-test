# frozen_string_literal: true

# app/controllers/users/registrations_controller.rb
module Users
  class RegistrationsController < Devise::RegistrationsController
    private

    def respond_with(resource, _opts = {})
      return error_response('Signed up failed.', resource.errors.full_messages) if resource.errors.present?

      @resource = resource if resource.present?
      return register_deleted if resource.deleted?
      return register_updated if account_update_params[:current_password].present?

      register_success
    end

    def register_success
      @message = 'Signed up and logged successfully.'
      render :create, status: :ok
    end

    def register_updated
      @message = 'User has been successfully updated.'
      render :update, status: :ok
    end

    def register_deleted
      @message = 'User has been successfully deleted.'
      render :destroy, status: :ok
    end

    def error_response(message, details)
      @error = { message:, details: }
      render 'shared/error', status: :unprocessable_entity
    end
  end
end

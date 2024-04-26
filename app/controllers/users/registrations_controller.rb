# frozen_string_literal: true

# app/controllers/users/registrations_controller.rb
module Users
  class RegistrationsController < Devise::RegistrationsController
    def destroy
      resource.update(deleted_at: Time.zone.now)
      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)

      yield resource if block_given?
      respond_with resource
    end

    private

    def respond_with(resource, _opts = {})
      error_response('Signed up failed.', resource.errors.full_messages) if resource.errors.present?

      @resource = resource if resource.present?
      return register_deleted if resource.deleted_at
      return register_updated if account_update_params[:current_password].present?

      register_success
    end

    def register_success
      @message = 'Signed up and logged successfully.'
      render 'users/registrations/create', status: :ok
    end

    def register_updated
      @message = 'User has been successfully updated.'
      render 'users/registrations/update', status: :ok
    end

    def register_deleted
      @message = 'User has been successfully deleted.'
      render 'users/registrations/destroy', status: :ok
    end

    def error_response(message, details)
      @error = { message:, details: }
      render 'shared/error', status: :unprocessable_entity
    end
  end
end
